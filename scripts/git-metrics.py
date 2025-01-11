#!/usr/bin/env python3

import json
import subprocess
import sys
from collections import defaultdict
from collections.abc import Container
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timedelta
from pathlib import Path

import matplotlib.pyplot as plt


class GitMetricsTracker:
    def __init__(self, repo_path: str) -> None:
        self.repo_path = Path(repo_path)
        self.data_dir = Path.home() / ".git_metrics"
        self.data_dir.mkdir(exist_ok=True)

    def run_git(self, args: list[str]) -> str:
        """Run a git command and return its output"""
        cmd = ["git", "-C", str(self.repo_path)] + args
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0:
            raise ValueError(
                f"Git command failed: {' '.join(cmd)}\nError: {result.stderr}"
            )
        return result.stdout.strip()

    def fetch_updates(self) -> None:
        """Fetch latest updates from remote"""
        self.run_git(["fetch", "origin"])

    def get_git_email(self) -> str:
        """Get the user's git email"""
        return self.run_git(["config", "user.email"])

    def get_default_remote_branch(self) -> str:
        """Get the default remote branch (either origin/staging or origin/main)"""
        try:
            # Check if origin/staging exists
            self.run_git(["rev-parse", "--verify", "origin/staging"])
            return "origin/staging"
        except ValueError:
            try:
                # Fall back to origin/main
                self.run_git(["rev-parse", "--verify", "origin/main"])
                return "origin/main"
            except ValueError:
                raise ValueError(
                    "Neither 'origin/staging' nor 'origin/main' branch found"
                )

    def get_repo_url(self) -> str:
        """Get repository remote URL"""
        return self.run_git(["remote", "get-url", "origin"])

    def parse_repo_info(self, url: str) -> tuple[str, str]:
        """Extract organization and repository name from GitHub URL"""
        # Handle both SSH and HTTPS URLs
        if url.startswith("git@"):
            path = url.split(":")[1]
        else:
            path = url.split("github.com/")[1]

        path = path.removesuffix(".git")
        org, repo = path.split("/")
        return org, repo

    def get_repo_identifier(self, branch: str) -> str:
        """Get a readable identifier for the repository and branch"""
        url = self.get_repo_url()
        org, repo = self.parse_repo_info(url)
        # Remove 'origin/' from branch name for the identifier
        clean_branch = branch.replace("origin/", "")
        return f"{org}_{repo}_{clean_branch}"

    def get_data_file(self, branch: str) -> Path:
        """Get path to data file for current repository/branch combination"""
        identifier = self.get_repo_identifier(branch)
        # Create a filename-safe version of the identifier
        safe_identifier = identifier.replace("/", "_").replace("\\", "_")
        return self.data_dir / f"{safe_identifier}.json"

    def get_commit_details(
        self,
        start_date: datetime,
        end_date: datetime,
        branch: str,
        excluded_commits: Container[str] = (),
    ) -> list[tuple[str, int]]:
        """Get commit dates and their line changes between start_date and end_date on specified branch"""
        email = self.get_git_email()

        # Files to exclude from line count
        excluded_files = {"poetry.lock"}

        # First get commit hashes and dates
        cmd = [
            "log",
            "--no-merges",  # Exclude merge commits
            f"--since={start_date.strftime('%Y-%m-%d')}",
            f"--until={end_date.strftime('%Y-%m-%d')}",
            "--format=%H %aI",  # Hash and ISO 8601 date
            f"--author={email}",
            branch,
        ]

        commit_info = self.run_git(cmd).split("\n") if self.run_git(cmd) else []

        # Get line changes for each commit
        result = []
        for line in commit_info:
            if not line:
                continue
            commit_hash, date = line.split(" ", 1)
            if commit_hash in excluded_commits:
                continue

            # Get number of lines changed
            stat_cmd = ["show", "--numstat", "--find-renames", "--format=", commit_hash]
            try:
                stat_output = self.run_git(stat_cmd)
                lines_changed = sum(
                    int(added) + int(deleted)
                    for line in stat_output.split("\n")
                    if line and not line.startswith("-")  # Skip binary files
                    for added, deleted, filename in [line.split(None, 2)]
                    if filename not in excluded_files  # Skip excluded files
                    and not filename.startswith("nlu_code/")
                )
                # if lines_changed > 3000:
                #     print(f"Warning: Large commit {commit_hash} with {lines_changed} lines changed")
                #     breakpoint()
            except (ValueError, IndexError):
                # Handle binary files or other parsing errors
                lines_changed = 0

            result.append((date, lines_changed))

        return result

    def analyze_daily_commits(
        self,
        start_date: datetime,
        end_date: datetime,
        excluded_commits: Container[str] = (),
    ) -> dict[str, dict[str, int]]:
        """Analyze commit frequency and lines changed by day within date range"""
        # Fetch latest updates first
        self.fetch_updates()

        # Get the default remote branch
        branch = self.get_default_remote_branch()

        commits = self.get_commit_details(
            start_date, end_date, branch, excluded_commits=excluded_commits
        )
        daily_metrics = defaultdict(lambda: {"commits": 0, "lines": 0})

        for date, lines in commits:
            if date:  # Skip empty lines
                day = date.split("T")[0]  # Get just the date part
                daily_metrics[day]["commits"] += 1
                daily_metrics[day]["lines"] += lines

        return dict(daily_metrics)

    def save_metrics(self, metrics: dict[str, int]) -> None:
        """Save metrics to repository-specific JSON file"""
        branch = self.get_default_remote_branch()
        data_file = self.get_data_file(branch)
        existing_data = {}
        if data_file.exists():
            with open(data_file, "r") as f:
                existing_data = json.load(f)

        existing_data.update(metrics)

        with open(data_file, "w") as f:
            json.dump(existing_data, f, indent=2)

    @staticmethod
    def get_all_repo_files() -> dict[Path, str]:
        """Get all repository data files and their default branches"""
        data_dir = Path.home() / ".git_metrics"
        if not data_dir.exists():
            return {}

        # Group files by repository (without branch)
        repo_files = {}
        for data_file in data_dir.glob("*.json"):
            # Split filename into parts
            parts = data_file.stem.rsplit("_", 1)
            if len(parts) != 2:
                continue

            repo_base, branch = parts
            # Prefer staging over main if both exist
            if repo_base not in repo_files or branch == "staging":
                repo_files[data_file] = branch

        return repo_files

    @classmethod
    def aggregate_metrics(
        cls, start_date: datetime, end_date: datetime, period: str = "daily"
    ) -> dict[str, dict[str, int]]:
        """Aggregate metrics across all repositories using their default branches"""
        daily_aggregated = defaultdict(lambda: {"commits": 0, "lines": 0})
        repo_files = cls.get_all_repo_files()

        if not repo_files:
            return {}

        start_date_str = start_date.strftime("%Y-%m-%d")
        end_date_str = end_date.strftime("%Y-%m-%d")

        for data_file, branch in repo_files.items():
            with open(data_file, "r") as f:
                repo_data = json.load(f)

            # Filter for the requested date range
            filtered_data = {
                date: metrics
                for date, metrics in repo_data.items()
                if start_date_str <= date <= end_date_str
            }

            for date, metrics in filtered_data.items():
                daily_aggregated[date]["commits"] += metrics["commits"]
                daily_aggregated[date]["lines"] += metrics["lines"]

        if period == "daily":
            return dict(daily_aggregated)

        # Aggregate by week or month
        aggregated = defaultdict(lambda: {"commits": 0, "lines": 0})
        for date_str, metrics in daily_aggregated.items():
            date = datetime.strptime(date_str, "%Y-%m-%d")
            if period == "weekly":
                # Use Sunday as the start of the week
                period_start = (date - timedelta(days=date.weekday() + 1)).strftime(
                    "%Y-%m-%d"
                )
            else:  # monthly
                period_start = date.strftime("%Y-%m")

            aggregated[period_start]["commits"] += metrics["commits"]
            aggregated[period_start]["lines"] += metrics["lines"]

        return dict(aggregated)

    @classmethod
    def plot_aggregated_metrics(
        cls,
        start_date: datetime,
        end_date: datetime,
        period: str = "daily",
        metric: str = "commits",
        per_commit: bool = False,
        excluded_commits: Container[str] = (),
    ) -> None:
        """Plot metrics across all repositories"""
        data = cls.aggregate_metrics(start_date, end_date, period)
        if not data:
            print("No data found for the specified criteria")
            return

        dates = sorted(data.keys())
        if per_commit:
            values = [
                (
                    data[date]["lines"] / data[date]["commits"]
                    if data[date]["commits"] > 0
                    else 0
                )
                for date in dates
            ]
            ylabel = "Lines Changed per Commit"
            title_metric = "Lines per Commit"
        else:
            values = [data[date][metric] for date in dates]
            ylabel = "Number of Commits" if metric == "commits" else "Lines Changed"
            title_metric = "Commits" if metric == "commits" else "Lines Changed"

        # Calculate statistics
        total_value = sum(values)
        average_value = total_value / len(values) if values else 0

        # Find busiest periods
        sorted_periods = sorted(zip(dates, values), key=lambda x: (-x[1], x[0]))
        top_periods = sorted_periods[:3]

        # Create the plot
        plt.figure(figsize=(12, 6))
        plt.bar(dates, values)

        # Add average line
        plt.axhline(y=average_value, color="r", linestyle="--", alpha=0.5)
        plt.text(
            dates[0],
            average_value,
            f" Avg: {average_value:.1f}",
            verticalalignment="bottom",
        )

        plt.xticks(rotation=45)
        title_period = period.capitalize()
        plt.title(f"{title_period} {title_metric} (All Repositories)")
        plt.xlabel("Date")
        plt.ylabel(ylabel)
        plt.tight_layout()

        # Print summary statistics
        metric_name = "lines per commit" if per_commit else title_metric.lower()
        print("\nSummary Statistics:")
        print(f"Total {metric_name}: {total_value:.1f}")
        print(f"Average {metric_name} per {period[:-2]}: {average_value:.1f}")
        print(f"\nBusiest periods:")
        for date, value in top_periods:
            print(f"{date}: {value:.1f} {metric_name}")
        plt.show()


def process_repository(
    repo_path: str,
    start_date: datetime,
    end_date: datetime,
    excluded_commits: Container[str] = (),
) -> tuple[str, str | None]:
    """Process a single repository and return status"""
    try:
        tracker = GitMetricsTracker(repo_path)
        metrics = tracker.analyze_daily_commits(
            start_date, end_date, excluded_commits=excluded_commits
        )
        tracker.save_metrics(metrics)
        return repo_path, None
    except Exception as e:
        return repo_path, str(e)


def parse_date(date_str: str) -> datetime:
    """Parse date string in YYYY-MM-DD format"""
    try:
        return datetime.strptime(date_str, "%Y-%m-%d")
    except ValueError:
        raise ValueError(
            f"Invalid date format: {date_str}. Please use YYYY-MM-DD format."
        )


def read_repo_paths(path: Path | None = None) -> list[str]:
    """Read repository paths from a file, one per line"""
    if path is None:
        path = Path.home() / ".git_metrics" / "repos.txt"

    if not path.exists():
        return []

    with open(path) as f:
        return [line.strip() for line in f if line.strip() and not line.startswith("#")]


def get_excluded_commits_from_file(exclude_file: Path) -> set[str]:
    """Read commit hashes to exclude from analysis"""
    if not exclude_file.exists():
        return set()

    with open(exclude_file) as f:
        return {line.strip() for line in f if line.strip() and not line.startswith("#")}


def main() -> None:
    import argparse

    parser = argparse.ArgumentParser(description="Track git commit metrics")
    repo_group = parser.add_mutually_exclusive_group()
    repo_group.add_argument(
        "-r",
        "--repos",
        nargs="+",
        help="Repository paths (default: current directory)",
    )
    repo_group.add_argument(
        "-f",
        "--file",
        type=Path,
        help="File containing repository paths (default: ~/.git_metrics/repos.txt)",
    )
    parser.add_argument(
        "-x",
        "--exclude-file",
        type=Path,
        default=Path.home() / ".git_metrics" / "excluded",
        help="File containing commit hashes to exclude from analysis (default ~/.git_metrics/excluded)",
    )
    parser.add_argument(
        "-s",
        "--start-date",
        help="Start date in YYYY-MM-DD format (default: 30 days ago)",
    )
    parser.add_argument(
        "-e",
        "--end-date",
        help="End date in YYYY-MM-DD format (default: today)",
    )
    parser.add_argument(
        "-d",
        "--days",
        type=int,
        help="Number of days to analyze (alternative to start/end dates)",
    )
    parser.add_argument(
        "-a",
        "--aggregate",
        action="store_true",
        help="Show aggregated metrics across all repositories",
    )
    parser.add_argument(
        "-j",
        "--jobs",
        type=int,
        default=None,
        help="Number of parallel jobs (default: number of CPUs)",
    )
    parser.add_argument(
        "-p",
        "--period",
        choices=["daily", "weekly", "monthly"],
        default="daily",
        help="Aggregation period (default: daily)",
    )
    parser.add_argument(
        "-m",
        "--metric",
        choices=["commits", "lines"],
        default="commits",
        help="Metric to plot (default: commits)",
    )
    parser.add_argument(
        "--per-commit",
        action="store_true",
        help="Show lines changed per commit (only valid with --metric lines)",
    )
    args = parser.parse_args()

    if args.per_commit and args.metric != "lines":
        parser.error("--per-commit can only be used with --metric lines")

    excluded_commits = get_excluded_commits_from_file(args.exclude_file)

    # Determine date range
    end_date = (
        parse_date(args.end_date)
        if args.end_date
        else datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
    )

    if args.start_date:
        start_date = parse_date(args.start_date)
    elif args.days:
        start_date = end_date - timedelta(days=args.days)
    else:
        start_date = end_date - timedelta(days=30)

    if start_date > end_date:
        parser.error("Start date must be before end date")

    if args.aggregate:
        # Just show aggregated view without processing any repositories
        GitMetricsTracker.plot_aggregated_metrics(
            start_date,
            end_date,
            args.period,
            metric=args.metric,
            per_commit=args.per_commit,
        )
        return

    # Get repository paths
    repo_paths = []
    if args.repos:
        repo_paths = args.repos
    elif args.file:
        repo_paths = read_repo_paths(args.file)
    else:
        repo_paths = read_repo_paths()
        if not repo_paths:
            repo_paths = ["."]

    # Process repositories in parallel
    with ThreadPoolExecutor(max_workers=args.jobs) as executor:
        future_to_path = {
            executor.submit(
                process_repository,
                path,
                start_date,
                end_date,
                excluded_commits=excluded_commits,
            ): path
            for path in repo_paths
        }

        errors = []
        for future in as_completed(future_to_path):
            path, error = future.result()
            if error:
                errors.append(f"Error processing {path}: {error}")
            else:
                print(f"Successfully processed {path}")

        if errors:
            print("\nErrors occurred:", file=sys.stderr)
            for error in errors:
                print(error, file=sys.stderr)

    # Show aggregated view after processing
    GitMetricsTracker.plot_aggregated_metrics(
        start_date,
        end_date,
        args.period,
        metric=args.metric,
        per_commit=args.per_commit,
    )


if __name__ == "__main__":
    main()
