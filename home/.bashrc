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

# git in the prompt
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWUNTRACKEDFILES=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWUPSTREAM=verbose

# source /etc/bash_completion.d/git
if [ "$color_prompt" = yes ]; then
    # colors
    t_reset="\[$(tput sgr0)\]"
    t_bold="\[$(tput bold)\]"
    t_underline="\[$(tput smul)\]"
    t_red="\[$(tput setaf 1)\]"
    t_green="\[$(tput setaf 2)\]"
    t_yellow="\[$(tput setaf 3)\]"
    t_blue="\[$(tput setaf 4)\]"
    t_purple="\[$(tput setaf 5)\]"
    t_teal="\[$(tput setaf 6)\]"
    t_white="\[$(tput setaf 7)\]"
else
    #PS1='\041\! @\t ${debian_chroot:+($debian_chroot)}[\u@\h:\w]$(__git_ps1) \$ '
    t_reset=
    t_bold=
    t_underline=
    t_red=
    t_green=
    t_yellow=
    t_blue=
    t_purple=
    t_teal=
    t_white=
fi

#PS1='\041\[\033[00;37m\]\!\[\033[00;00m\] @\[\033[00;33m\]\t\[\033[00;00m\] ${debian_chroot:+($debian_chroot)}[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]$(__git_ps1 " (\[\033[01;31m\]%s\[\033[00;00m\])")\$ '
ques_part="$t_bold?\$(ecode=\$?; if [[ \$ecode == 0 ]]; then echo -n $t_green; else echo -n $t_red; fi; echo -n \$ecode)$t_reset"
bang_part="${t_white}${t_bold}\041$t_reset${t_yellow}\!${t_reset}"
timestamp="$t_white$t_bold@$t_reset${t_green}\D{%Y-%m-%d}$t_blue \D{%H:%M:%S}${t_reset}"
chroot_part='${debian_chroot:+($debian_chroot)}'
#dir_part='[${t_bold}${t_green}\u@\h${t_reset}:${t_bold}${t_blue}\w${t_reset}]'
#dir_part="$t_red\[$t_bold\]\[$t_red\][\[$t_yellow\]\u\[$t_green\]@\[$t_blue\]\h\[$t_purple\]:${t_teal}\w\[$t_red\]]\[$t_reset\]"
unamehost="${t_bold}${t_yellow}\u${t_reset}@${t_purple}${t_bold}\h${t_reset}"
dir_part="$t_white[$t_bold${t_teal}\w$t_reset$t_white]$t_reset"
git_part="\$(__git_ps1 \" (${t_bold}${t_red}%s${t_reset})\")"
# prompt_part=$'\n\xe2\x9e\x94\$ ' # fat arrow
# prompt_part=$'\n $t_green\xe2\x87\xb6 ' # triple arrow
# prompt_part='\n $t_bold${t_blue}\h${t_white}\$ '
prompt_part="\n${unamehost}$t_bold${t_blue}\$${t_reset} "
#prompt_part='${t_bold}${t_blue}\$${t_reset}'
PS1="$ques_part $bang_part $timestamp $chroot_part$dir_part$git_part$prompt_part$t_reset"

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

# old WP stuff
# export WPORG_USER=sagittarian
# Composer scripts
# export PATH=$HOME/.composer/bin:$PATH

# WP-CLI completions
# source $HOME/.composer/vendor/wp-cli/wp-cli/utils/wp-completion.bash

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_vars ]; then
    . ~/.bash_vars
fi

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source /usr/local/bin/virtualenvwrapper.sh

# working on foreman locally
export RAILS_ENV=development

# rvm
export PATH="$HOME/.rvm/bin:$PATH"
source ~/.rvm/scripts/rvm
