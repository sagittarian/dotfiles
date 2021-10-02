#!/bin/bash

result=0
failures=0

function failure {
    echo "$(tput bold)$(tput setaf 1)$@$(tput sgr0)"
}

function success {
    echo "$(tput bold)$(tput setaf 2)$@$(tput sgr0)"
}

function cmd {
    eval "$@"
    rc=$?
    if [ $rc -ne 0 ]; then
        result=$rc
        failures=$(($failures+1))
        failure '    FAILED'
    else
        success '    OK'
    fi
    return $rc
}

SRC=$HOME/src

# role: ensure-dir-structure
echo "Checking directory structure... "
ds="Downloads bin src"
for d in $ds; do
    echo "  ~/$d"
    cmd test -d $HOME/$d
done

# role: install-packages
echo "Checking that no packages need to be upgraded... "
cmd 'test "$(apt list --upgradable -qq 2> /dev/null)" = ""'

echo Checking that packages are installed
cmds="
    git gitk i3 emacs workrave ag firefox terminator dolphin kmix jq ghc
    python3 ksysguard kate kwrite kdesudo sshd ctags isympy pavucontrol
    gwenview meld fish google-chrome youtube-dl node npm anki
    dmenu_run_aliases"
for cmd in $cmds; do
    echo -n "  $cmd: "
    cmd which $cmd
done

echo Checking for pip and virtualenv
echo '  /usr/bin/python -m pip'
cmd "/usr/bin/python -m pip -h > /dev/null"
echo '  /usr/bin/python3 -m pip'
cmd "/usr/bin/python3 -m pip -h > /dev/null"
echo '  /usr/bin/python -m virtualenv'
cmd "/usr/bin/python -m virtualenv -h > /dev/null"

# role: create-symlinks
test -d $SRC
for d in .config .config/i3 .local/share; do
    echo Checking for directory $HOME/$d
    cmd test -d $HOME/$d
done

symlinks="
    .ackrc .agignore .bash_aliases .bashrc .bash_vars .config/pip
    .config/terminator .config/uzbl .config/youtube-dl.conf
    .config/i3/config .emacs.d .gitconfig .inputrc .local/share/uzbl
    .profile .vimrc"
for symlink in $symlinks; do
    echo Checking for symlink $HOME/$symlink
    cmd "test -h $HOME/$symlink && echo "\""  $HOME/$symlink -> \$(readlink -f $HOME/$symlink)"\"
done

# role: install-nodejs, install-anki done in the program checks above

# role: install-docker
echo -ne 'Checking for docker\n  '
cmd 'which docker && docker ps > /dev/null'

# role: init-emacs
# XXX how to check?

# role: crontab
echo -n "Checking for DISPLAY=:0 in crontab: "
cmd 'crontab -l | grep ^DISPLAY=.\\?:0.\\?$'
# echo -ne "Checking for microbreak cron job\n  "
# cmd "crontab -l | grep 'notify-send.*microbreak'"

# role: git-bootstrap
echo Checking for org repository
cmd "(cd $SRC/org && git status > /dev/null)"
echo Checking for notes repository
cmd "(cd $SRC/notes && git status > /dev/null)"

# role: tagtime
echo Checking for pytagtime repository
cmd "(cd $SRC/pytagtime && git status > /dev/null)"

echo Checking for .pytagtimerc
cmd test -e $HOME/.pytagtimerc

echo Checking for Supervisord
cmd "service supervisor status > /dev/null"
echo -ne "Checking for supervisorctl\n  "
cmd which supervisorctl

echo -ne "Checking for cron job to notify if editing tagtime\n  "
cmd "crontab -l | grep 'pgrep.*GntGvzr'"

if [ $failures -eq 0 ]; then
    success ALL TESTS PASSED
else
    if [ $failures -eq 1 ]; then
        failure THERE WAS 1 FAILED TEST
    else
        failure THERE WERE $failures FAILED TESTS
    fi
fi

exit $result
