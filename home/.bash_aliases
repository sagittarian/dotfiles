# Alias definitions.

alias ack=ack-grep
alias 'ps?'='ps aux | grep -i '
alias findname='findname () { find -iname "*$1*"; }; findname'

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
alias cw="i3-msg move workspace to output left"
alias flipw='i3-msg move workspace to output up'

#alias ghc=ghc-7.8.2
#alias ghci=ghci-7.8.2
alias runnode="nodemon -x authbind node bin/www"
alias runrails="authbind --deep bundle exec rails server -p 80"
alias localeup="localeapp pull && rake i18n:js:export"
alias mirror-site="wget -m -k -p -E"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."