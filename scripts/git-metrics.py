#!/usr/bin/env python3
import json
import math
import subprocess
import sys
from collections import defaultdict
from collections.abc import Container
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timedelta
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


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
        show_heatmap: bool = True,
    ) -> None:
        """Plot commit metrics across all repositories"""
        metrics = cls.aggregate_metrics(start_date, end_date, period)
        if not metrics:
            print("No data found for the specified criteria")
            return

        # Create main time series plot with two y-axes
        fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 12), height_ratios=[2, 1])
        dates = sorted(metrics.keys())

        # Plot raw commits
        commits = [metrics[date]["commits"] for date in dates]
        bars = ax1.bar(dates, commits, alpha=0.6, label="Raw Commits")
        ax1.set_ylabel("Number of Commits")

        # Calculate and plot normalized commits on secondary y-axis
        normalized = calculate_normalized_commits(metrics)
        norm_values = [normalized[date] for date in dates]
        ax1_twin = ax1.twinx()
        line = ax1_twin.plot(
            dates, norm_values, color="red", label="Normalized Commits"
        )[0]
        ax1_twin.set_ylabel("Normalized Commits")

        # Add legends
        # Use the first bar and the line for the legend
        ax1.legend(
            [bars.patches[0], line],
            ["Raw Commits", "Normalized Commits"],
            loc="upper left",
        )

        # Rotate x-axis labels
        ax1.tick_params(axis="x", rotation=45)

        # Add title
        title_period = period.capitalize()
        ax1.set_title(f"{title_period} Commit Metrics (All Repositories)")

        # Create day-of-week heatmap if showing daily data
        if period == "daily" and show_heatmap:
            create_weekday_heatmap(
                metrics, start_date=start_date, end_date=end_date, ax=ax2
            )
        else:
            fig.delaxes(ax2)
            fig.set_size_inches(12, 6)

        plt.tight_layout()

        # Print summary statistics
        print("\nSummary Statistics:")
        print(f"Total commits: {sum(commits)}")
        avg_commits = sum(commits) / len(commits) if commits else 0
        print(f"Average commits per {period[:-2]}: {avg_commits:.1f}")
        print(f"Average normalized commits: {sum(norm_values) / len(norm_values):.1f}")
        plt.show()


def calculate_normalized_commits(
    metrics: dict[str, dict[str, int]]
) -> dict[str, float]:
    """Calculate normalized commit scores taking into account lines/commit ratio"""
    # First get the overall average lines per commit
    total_lines = sum(day["lines"] for day in metrics.values())
    total_commits = sum(day["commits"] for day in metrics.values())
    avg_lines_per_commit = total_lines / total_commits if total_commits > 0 else 0

    normalized = {}
    for date, day_metrics in metrics.items():
        if day_metrics["commits"] == 0:
            normalized[date] = 0
            continue

        # Calculate how this day's commits compare in size to the average
        day_avg_lines = day_metrics["lines"] / day_metrics["commits"]
        size_factor = (
            day_avg_lines / avg_lines_per_commit if avg_lines_per_commit > 0 else 1
        )

        # Apply a dampening function to avoid over-emphasizing very large commits
        size_adjustment = math.log2(1 + size_factor)

        # Combine number of commits with size adjustment
        normalized[date] = day_metrics["commits"] * size_adjustment

    return normalized


def create_weekday_heatmap(
    metrics: dict[str, dict[str, int]],
    start_date: datetime,
    end_date: datetime,
    ax: plt.Axes,
) -> None:
    """Create a heatmap showing average commits by day of week"""
    # Initialize data structure for day-of-week aggregation
    weekday_data = defaultdict(lambda: {"total_commits": 0, "count_days": 0})

    # Iterate through all days in the range
    current_date = start_date
    while current_date <= end_date:
        weekday = current_date.strftime("%A")  # Full weekday name
        date_str = current_date.strftime("%Y-%m-%d")

        # Count this day and add its commits (if any)
        weekday_data[weekday]["count_days"] += 1
        if date_str in metrics:
            weekday_data[weekday]["total_commits"] += metrics[date_str]["commits"]

        current_date += timedelta(days=1)
    # Calculate averages
    weekday_order = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
    ]
    commit_avgs = [
        weekday_data[day]["total_commits"] / weekday_data[day]["count_days"]
        for day in weekday_order
    ]

    # Create heatmap
    data = np.array([commit_avgs])
    im = ax.imshow(data, aspect="auto", cmap="YlOrRd")

    # Customize appearance
    ax.set_xticks(range(len(weekday_order)))
    ax.set_xticklabels(weekday_order, rotation=45)
    ax.set_yticks([])

    # Add color bar
    plt.colorbar(im, ax=ax, orientation="vertical", label="Average Commits")
    ax.set_title("Average Commits by Day of Week")

    # Add value annotations
    for i, avg in enumerate(commit_avgs):
        ax.text(i, 0, f"{avg:.1f}", ha="center", va="center")


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
    parser.add_argument(
        "-H", "--heatmap", action="store_true", default=False, help="Show a heatmap"
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
            start_date, end_date, period=args.period, show_heatmap=args.heatmap
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
        start_date, end_date, period=args.period, show_heatmap=args.heatmap
    )


if __name__ == "__main__":
    main()
