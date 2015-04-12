# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# source /etc/bash_completion.d/git
if [ "$color_prompt" = yes ]; then
    PS1='\041\[\033[00;37m\]\!\[\033[00;00m\] @\[\033[00;33m\]\t\[\033[00;00m\] ${debian_chroot:+($debian_chroot)}[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]$(__git_ps1 " (\[\033[01;31m\]%s\[\033[00;00m\])")\$ '
else
    PS1='\041\! @\t ${debian_chroot:+($debian_chroot)}[\u@\h:\w]$(__git_ps1) \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function lmv() {
	fullsource=$(readlink -fn $1)
	fulldest=$(readlink -mn $2)
	mkdir -p "$2" && mv "$1" "$2" && ln -s "$fulldest/$(basename $1)" "$fullsource";
}

# old WP stuff
# export WPORG_USER=sagittarian
# Composer scripts
# export PATH=$HOME/.composer/bin:$PATH

# WP-CLI completions
# source $HOME/.composer/vendor/wp-cli/wp-cli/utils/wp-completion.bash

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export NODE_ENV=DEV
export RAILS_ENV=development
export PYTHONPATH=$HOME/python:$PYTHONPATH

export PATH=$HOME/bin:$PATH
export CDPATH=:..:~:~/src:~/doc:$CDPATH
export TERMINAL=/usr/bin/terminator
#export TERMINAL=/usr/bin/konsole
#export TERMINAL=/usr/bin/rxvt

# cabal
export PATH="$HOME/.cabal/bin:$HOME/bin/.cabal-sandbox/bin:$PATH"

# rvm
export PATH="$HOME/.rvm/bin:$PATH"
source ~/.rvm/scripts/rvm

# gradle and java
export GRADLE_HOME=/home/adam/src/t2k/infra/gradle
export PATH="$PATH:$GRADLE_HOME/bin"
export JAVA_HOME=/usr/lib/jvm/default-java
#org.gradle.java.home=d:/t2kdev/infra/Java/win32

export EDITOR
