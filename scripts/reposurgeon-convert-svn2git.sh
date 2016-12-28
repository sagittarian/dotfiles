#!/bin/bash
# source: http://stackoverflow.com/questions/22700593/how-do-i-convert-an-svn-repo-to-git-using-reposurgeon
PROJECT=myproject
svnrepo=svn+ssh://rubo77@myserver.de/var/svn-repos/$PROJECT
# or something like svnrepo=https://svn.origo.ethz.ch/$PROJECT

gitrepo=/tmp/$PROJECT-git

cd /tmp

# start over with:
#rm $PROJECT-mirror/ $PROJECT-git/ -Rf

echo
echo pull/copy the repository...
#repopuller $svnrepo
# or copy it if it is on the same server:
cp -av /var/svn-repos/$PROJECT /tmp/$PROJECT-mirror
echo
echo start conversion...

reposurgeon <<EOF
read /tmp/$PROJECT-mirror
prefer git
edit
references lift
rebuild $gitrepo
EOF
echo ...finished

# now filter out all falsly generated .gitignore files:
cd $gitrepo/
git filter-branch --force --index-filter      \
 "git rm --cached --ignore-unmatch $(find . -name .gitignore|xargs )"  \
 --prune-empty --tag-name-filter cat -- --all
I filter out the .gitignore files like github has documented with filter-branch because otherwise, they will create commits in all tags (see note below). You have to create a new .gitignore file when you are done.

This may take a while, so you should start it inside tmux or screen with

tmux
bash /usr/local/sbin/reposurgeon-convert-svn2git
Take care, that all your tags are git conform.

I got the error

reposurgeon% reposurgeon: exporting...fatal: Branch name doesn't conform to GIT standards: refs/tags/version 3.6.2
So I cleaned up the svn repository and removed this branch, so all tags and branches are conform:

svn rm "$svnrepo/tags/version 3.6.2"
and deleted it from all history with this script: How do I remove an SVN tag completely that contains spaces?

Then I started over with the script:

rm $PROJECT-mirror/ $PROJECT-git/ -Rf
bash /usr/local/sbin/reposurgeon-convert-svn2git
Note:
Without removing the .gitignore files, it looks all the same in git as in SVN before except one thing: all tags are ordered in the log at the exact date they were tagged, instead of the commit they started ad. It seems a .gitignore file is added there in the conversion process to each branch and tag, but that .gitignore-file results in a commit inside those tags with the timestamp of the tag-creation.
New tags are ok, they appear right at the revision they belong to. (see Convert an SVN repository to git with reposurgeon without creating .gitignore files?)
