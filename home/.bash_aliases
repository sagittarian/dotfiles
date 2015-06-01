# Alias definitions.

alias ack=ack-grep
alias 'ps?'='ps aux | grep -i '
alias findname='findname () { find -iname "*$1*"; }; findname'
alias ipy=ipython3
alias ipy2=ipython
alias bpy=bpython3
alias bpy2=bpython

if hash emacsclient.emacs-snapshot 2>/dev/null; then
    alias emacs=emacs-snapshot
    alias emacsclient=emacsclient.emacs-snapshot
    alias e="emacsclient.emacs-snapshot -n -c -a ''"
    EDITOR=emacsclient.emacs-snapshot
else
    alias e="emacsclient -n -c -a ''"
    alias e.="emacsclient -n -c -a '' ."
    EDITOR=emacsclient
fi

export EDITOR

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
alias setvga='xrandr --output VGA1 --auto --right-of LVDS1'
alias setdp='xrandr --output DP1 --mode 1920x1080 --above eDP1'
#alias setdp='xrandr --output DP1 --mode 1152x864 --left-of eDP1'
#alias setdp='xrandr --output DP1 --mode 1280x1024 --above eDP1'
alias hdmioff="xrandr --output HDMI1 --off"
alias vgaoff='xrandr --output VGA1 --off'
alias dpoff='xrandr --output DP1 --off'
alias dualmonoff='xrandr --output DP1 --off --output DP2 --off'
alias dualmon='xrandr --output DP2 --auto --right-of eDP1 --output DP1 --auto --right-of DP2'

function mkcd () {
    mkdir -p $1 && cd $1;
}

function xinput_set_prop () {
    deviceid=$(xinput list | grep -i $1 | ruby -n -e '$_ =~ /id=(\d+)/; puts $+')
    xinput set-prop $deviceid "$2" "$3"
}

alias setmouse="xinput set-button-map \$(xinput list | grep -i mouse | grep -vi generic | perl -n -e'/id=(\d+)/ && print \$1') 3 2 1"
alias touchpad-enable="xinput_set_prop touchpad 'Device Enabled' 1 && xinput_set_prop trackpoint 'Device Enabled' 1"
alias touchpad-disable="xinput_set_prop touchpad 'Device Enabled' 0 && xinput_set_prop trackpoint 'Device Enabled' 1"

#alias setmon="xrandr --output HDMI1 --auto --left-of LVDS1"
alias setkb="setxkbmap -layout 'us(dvp),il' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias setkbru="setxkbmap -layout 'us(dvp),ru' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"

alias cycleworkspace="i3-msg move workspace to output left"
alias cycw="i3-msg move workspace to output left"
#alias cw="i3-msg move workspace to output left"
function cw () {
    i3-msg move workspace to output ${1:-left}
}
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
alias ff='firefox -no-remote'

alias apt-get="apt-get --yes"

#alias findold="find . ! -newermt $(date +%Y-%m-%d -d '1 day ago') ! -name ."

#alias g=git
alias gst="git status"
alias gco="git checkout"
alias gci="git commit"
alias gd="git diff"
alias gbr="git branch"
alias gvi="git bisect visualize"
alias gbi="git bisect"

function swapgood () {
	alias good='git bisect bad'
	alias bad='git bisect good'
}
function unswapgood () {
	alias good='git bisect good'
	alias bad='git bisect bad'
}
unswapgood

function wrapstash () {
    git stash && "$@" && git stash pop
}

# make some commands pay attention to aliases
alias sudo='sudo '
alias xargs='xargs '

# create a directory and cd into it
function mkcd () {
	mkdir -p $1 && cd $1
}

# move a file and leave a symlink pointing to the new location behind
function lmv() {
	fullsource=$(readlink -fn $1)
	fulldest=$(readlink -mn $2)
	mkdir -p "$2" && mv "$1" "$2" && ln -s "$fulldest/$(basename $1)" "$fullsource";
}

#alias urldecode='ruby -ne "puts \$_.gsub(/%([0-9A-Fa-f][0-9A-Fa-f])/) { |m| \$1.hex.chr; }"'
alias urldecode='ruby -nr uri -e "puts URI.decode \$_.chomp"'
alias urlencode='ruby -nr uri -e "puts URI.encode \$_.chomp"'
alias querydecode='ruby -nr uri -e "puts URI.decode_www_form(61.chr + \$_.chomp).to_h[%{}]"'
alias queryencode='ruby -nr uri -e "puts URI.encode_www_form(nil => \$_.chomp)[1..-1]"'


# ghc

alias ghc-sandbox="ghc -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias ghci-sandbox="ghci -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias runhaskell-sandbox="runhaskell -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"

alias inst='sudo apt-get install'


alias unhist='unset HISTFILE'

# personal shortcuts
alias org='cd ~/src/org'
alias dl='cd ~/src/dl'

# t2k
alias extract-data="jq -r '.[keys[0]].convertedData'"
function t2k_hotfix_patch () {
    git format-patch --stdout ${@:-HEAD^} | (cd $T2K_HOTFIX_BRANCH && patch -p1)
}

# convert to svn
alias svn-authors-transform='svn log -q | awk -F '"'"'|'"'"' '"'"'/^r/ {sub("^ ", "", $2); sub(" $", "", $2); print $2" = "$2" <"$2">"}'"'"' | sort -u'

alias rm_git_svn_id="ruby -n -i.orig -e '"

alias rnd="python3 -c 'import random, sys; print(random.choice(sys.argv[1:]))'"
