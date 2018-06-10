# Alias definitions.

alias 'ps?'='ps aux | grep -i '
#alias findname='findname () { find -iname "*$1*"; }; findname'
alias fname='find -name'
alias ipy=ipython3
alias ipy2=ipython
alias bpy=bpython3
alias bpy2=bpython

alias pyecho="python -c 'import sys; print(sys.argv[1:])'"

if hash emacsclient.emacs-snapshot 2>/dev/null; then
    alias emacs=emacs-snapshot
    alias emacsclient=emacsclient.emacs-snapshot
    alias e="emacsclient.emacs-snapshot -n -c -a ''"
    EDITOR=emacsclient.emacs-snapshot
else
    alias e="emacsclient -n -c -a ''"
    alias e.="emacsclient -n -c -a '' ."
    alias ec="emacsclient -nw"
    EDITOR=emacsclient
fi
export EDITOR

alias ebang="emacsclient -n -c \$(eval \$(fc -ln -1))"

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
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function mkcd () {
    mkdir -p $1 && cd $1;
}

alias setkb="setxkbmap -layout 'us(dvp),il' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias setkbus="setxkbmap -layout 'us,il' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"
alias setkbdana="setxkbmap -layout 'us,il' -option "" && setxkbmap -layout 'us,il' -option grp:shifts_toggle"
alias setkbru="setxkbmap -layout 'us(dvp),ru' -option 'grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps'"

#alias ghc=ghc-7.8.2
#alias ghci=ghci-7.8.2
# alias runnode="nodemon -x authbind node bin/www"
# alias runrails="authbind --deep bundle exec rails server -p 80"
# alias localeup="localeapp pull && rake i18n:js:export"
alias mirror-site="wget -m -k -p -E"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ff='firefox --no-remote --ProfileManager'

alias apt-get="apt-get --yes"

#alias findold="find . ! -newermt $(date +%Y-%m-%d -d '1 day ago') ! -name ."

#alias g=git
alias gst="git status"

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

# convert yaml to json and the other way around
alias y2j="python -c 'import yaml, json, sys; print(json.dumps(yaml.load(sys.stdin.read()), indent=4))'"
#alias j2y="python -c 'import yaml, json, sys; print(yaml.dump(json.loads(sys.stdin.read())))'"
alias j2y="ruby -r json -r yaml -e 'puts YAML.dump JSON.load \$stdin.read'"

alias rnd="python3 -c 'import random, sys; print(random.choice(sys.argv[1:]))'"
alias rndchars="strings /dev/urandom | grep -o '[A-Za-z0-9]' | head" # | tr -d "\n"

function showpypath () {
	python -c "import re, $1; print(re.search(r\"([^']+.py)c?'>$\", str($1)).group(1))"
}

# virtualenv
alias wo=workon

# clojure/clojurescript
alias clojure='java -cp cljs.jar:src clojure.main'

alias xsel='xclip -sel clip'

alias normdir='cd $(readlink -f $(pwd))'

alias space='du -s * | sort -g'

function cppath {
    file=$1
    echo -n $(readlink -f $file) | xclip -sel clip
}

alias dux='du -sc * | sort -g'
which emacs25 > /dev/null && alias emacs=emacs25
which emacsclient25 > /dev/null && alias emacsclient=emacsclient25
