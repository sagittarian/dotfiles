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
    PS1='\041\[\033[00;37m\]\!\[\033[00;00m\] @\[\033[00;33m\]\t\[\033[00;00m\] ${debian_chroot:+($debian_chroot)}[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]\[\033[01;31m\]$(__git_ps1)\[\033[00;00m\] \$ '
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ack=ack-grep
alias 'ps?'='ps aux | grep -i '

if hash emacsclient.emacs-snapshot 2>/dev/null; then
    alias emacs=emacs-snapshot
    alias emacsclient=emacsclient.emacs-snapshot
    alias e="emacsclient.emacs-snapshot -n -c"
    EDITOR=emacsclient.emacs-snapshot
else
    alias e="emacsclient -n -c"
    EDITOR=emacsclient
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# monitor setting aliases
alias sethdmi="xrandr --output HDMI1 --auto --left-of LVDS1"
alias setvga='xrandr --output VGA1 --auto --left-of LVDS1'
alias setdp='xrandr --output DP1 --mode 1920x1080 --above eDP1'
#alias setdp='xrandr --output DP1 --mode 1152x864 --left-of eDP1'
#alias setdp='xrandr --output DP1 --mode 1280x1024 --above eDP1'
alias hdmioff="xrandr --output HDMI1 --off"
alias vgaoff='xrandr --output VGA1 --off'
alias dpoff='xrandr --output DP1 --off'

alias setmouse="xinput set-button-map \$(xinput list | grep -i mouse | perl -n -e'/id=(\d+)/ && print \$1') 3 2 1"
#alias setmon="xrandr --output HDMI1 --auto --left-of LVDS1"
alias setkb="setxkbmap -layout 'us(dvp),il' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias setkbru="setxkbmap -layout 'us(dvp),ru' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"

alias cycleworkspace="i3-msg move workspace to output left"
alias cycw="i3-msg move workspace to output left"
alias flipw='i3-msg move workspace to output up'

#alias ghc=ghc-7.8.2
#alias ghci=ghci-7.8.2
alias runnode="nodemon -x authbind node bin/www"
alias runrails="authbind --deep bundle exec rails server -p 80"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

export NODE_ENV=DEV
export PYTHONPATH=$HOME/python:$PYTHONPATH

# rvm
export PATH="$HOME/.rvm/bin:$PATH"
source ~/.rvm/scripts/rvm

# cabal
export PATH="$HOME/.cabal/bin:$PATH"

export PATH=$HOME/bin:$PATH
export CDPATH=:..:~:~/src:~/doc:$CDPATH
export TERMINAL=/usr/bin/terminator
#export TERMINAL=/usr/bin/konsole
#export TERMINAL=/usr/bin/rxvt

export EDITOR
