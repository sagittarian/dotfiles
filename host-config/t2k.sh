# gradle and java
export GRADLE_HOME=/home/adam/src/t2k/infra/gradle
export PATH="$PATH:$GRADLE_HOME/bin"
export JAVA_HOME=/usr/lib/jvm/default-java
#org.gradle.java.home=d:/t2kdev/infra/Java/win32

# t2k
export T2K_HOTFIX_BASE=/home/adam/src/hotfix29
export T2K_HOTFIX_BRANCH=$T2K_HOTFIX_BASE/projects/player/src/main/webapp
export T2K_HOTFIX_VERSION=$T2K_HOTFIX_BASE/install/src/main/assembly/files/version.properties.tmpl

# t2k
alias extract-data="jq -r '.[keys[0]].convertedData'"

function t2k_hotfix_patch {
    git format-patch --stdout ${@:-HEAD^} | (cd $T2K_HOTFIX_BRANCH && patch -p1)
}

# convert to svn
alias svn-authors-transform='svn log -q | awk -F '"'"'|'"'"' '"'"'/^r/ {sub("^ ", "", $2); sub(" $", "", $2); print $2" = "$2" <"$2">"}'"'"' | sort -u'

alias rm_git_svn_id="ruby -n -i.orig -e '"
