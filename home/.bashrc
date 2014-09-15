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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# aliases for emacsclient
alias ec=emacsclient
alias ecn='emacsclient -n'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ack=ack-grep

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# fancier prompt
#PS1="\D{%Y-%m-%d} \t: $PS1"
PS1="\041\!@\t|$PS1"

# old WP stuff
# export WPORG_USER=sagittarian
# Composer scripts
# export PATH=$HOME/.composer/bin:$PATH

# WP-CLI completions
# source $HOME/.composer/vendor/wp-cli/wp-cli/utils/wp-completion.bash

alias 'ps?'='ps aux | grep -i '

# start an emacs daemon
# emacs --daemon
#alias emacs='emacsclient -c -n -a ""'
alias emacs=emacs-snapshot
alias emacsclient=emacsclient.emacs-snapshot
alias e="emacsclient.emacs-snapshot -n -c"
alias hdmioff="xrandr --output HDMI1 --off"
alias vgaoff='xrandr --output VGA1 --off'
alias dpoff='xrandr --output DP1 --off'
alias setmouse="xinput set-button-map \$(xinput list | grep -i mouse | perl -n -e'/id=(\d+)/ && print \$1') 3 2 1"
alias setmon="xrandr --output HDMI1 --auto --left-of LVDS1"
alias sethdmi="xrandr --output HDMI1 --auto --left-of LVDS1"
alias setvga='xrandr --output VGA1 --auto --left-of LVDS1'
#alias setdp='xrandr --output DP1 --mode 1152x864 --left-of eDP1'
#alias setdp='xrandr --output DP1 --mode 1280x1024 --above eDP1'
alias setdp='xrandr --output DP1 --mode 1920x1080 --above eDP1'
alias setkb="setxkbmap -layout 'us(dvp),il' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias setkbru="setxkbmap -layout 'us(dvp),ru' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias cycleworkspace="i3-msg move workspace to output left"
alias cycw="i3-msg move workspace to output left"
alias flipw='i3-msg move workspace to output up'
alias runnode="nodemon -x authbind node bin/www"
#alias ghc=ghc-7.8.2
#alias ghci=ghci-7.8.2
alias runrails="authbind --deep rails server -p 80"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


export PATH=$HOME/bin:$PATH
export CDPATH=:..:~:~/src:~/doc:$CDPATH
export TERMINAL=/usr/bin/terminator
#export TERMINAL=/usr/bin/konsole
#export TERMINAL=/usr/bin/rxvt
#export EDITOR=emacs
export EDITOR=emacsclient.emacs-snapshot
export PYTHONPATH=$HOME/python:$PYTHONPATH
export NODE_ENV=DEV

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# cabal
export PATH="$PATH:$HOME/.cabal/bin"


source ~/.rvm/scripts/rvm
