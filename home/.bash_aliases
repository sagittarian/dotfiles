# Alias definitions.

alias 'ps?'='ps aux | grep -i '
#alias findname='findname () { find -iname "*$1*"; }; findname'
alias fname='find -name'
alias ipy3=ipython3
alias ipy=ipython
alias bpy=bpython3
alias bpy2=bpython

alias pyecho="python -c 'import sys; print(sys.argv[1:])'"

ecl=emacsclient
if which emacs27 > /dev/null; then
     alias emacs=emacs27
     alias emacsclient=emacsclient27
     ecl=emacsclient27
fi

ebase="$ecl -n -c -a ''"
alias e="$ebase"
alias e.="$ebase ."
alias ed.="$ebase ."
function em. {
    $ebase -e "(magit-status \"$(pwd)\")"
}
alias ec="$ecl -nw"
export EDITOR="$ecl -nw"
export VISUAL="$ecl -c"
export KUBE_EDITOR="$VISUAL"

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
    mkdir -p "$1" && cd "$1"
}

xkbopts='grp:shifts_toggle,esperanto:dvorak,lv3:ralt_switch,ctrl:swapcaps,eurosign:4'
alias setkb="setxkbmap -layout 'us(dvp),il' -option '' -option '$xkbopts'"
alias setkbus="setxkbmap -layout 'us,il' -option '' '$xkbopts'"
alias setkbdana="setxkbmap -layout 'us,il' -option '' && setxkbmap -layout 'us,il' -option grp:shifts_toggle"
alias setkbru="setxkbmap -layout 'us(dvp),ru' -option '' -option '$xkbopts'"

#alias ghc=ghc-7.8.2
#alias ghci=ghci-7.8.2
# alias runnode="nodemon -x authbind node bin/www"
# alias runrails="authbind --deep bundle exec rails server -p 80"
# alias localeup="localeapp pull && rake i18n:js:export"
alias mirror-site="wget -m -k -p -E"

# alias .="cd $(readlink -f .)"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ff='firefox --ProfileManager'
alias ffp='firefox -P'

alias ctrlcntr='unset XDG_CURRENT_DESKTOP && unity-control-center'

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
alias nohup='nohup '

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
alias y2j="python -c 'import yaml, json, sys; print(chr(10).join(json.dumps(doc) for doc in yaml.load_all(sys.stdin.read(), Loader=getattr(yaml, \"CLoader\", yaml.Loader))))'"
# alias j2y="python -c 'import yaml, json, sys; print(yaml.dump(json.loads(sys.stdin.read())))'"
alias j2y="ruby -r json -r yaml -e 'puts YAML.dump JSON.load \$stdin.read'"
alias py2j="python -c 'import sys, json; print(json.dumps(eval(sys.stdin.read()), indent=4))'"

function j2t {
    python - <(cat) <<EOF
import json
import sys
import tomli_w

def rmnull(root):
    if isinstance(root, dict):
        return {k: rmnull(v) for (k, v) in root.items() if v is not None}
    if isinstance(root, (tuple, list)):
        return type(root)(rmnull(item) for item in root if item is not None)
    return root

root = json.loads(open(sys.argv[1]).read())
if isinstance(root, list):
   root = dict(items=root)
print(tomli_w.dumps(rmnull(root), multiline_strings=True))
EOF
}

alias t2j="python -c 'import sys, tomli, json; \
      print(json.dumps(tomli.load(sys.stdin), indent=2))'"

alias pretty_xml="python -c 'import sys; from xml.dom.minidom import parse; \
      print(parse(sys.stdin).toprettyxml(indent=chr(32)*4))'"

alias rnd="python3 -c 'import random, sys; print(random.choice(sys.argv[1:]))'"
alias rndchars="strings /dev/urandom | grep -o '[A-Za-z0-9]' | head" # | tr -d "\n"

function pywhich () {
	python -c "import re, $1; print(re.search(r\"([^']+.py)c?'>$\", str($1)).group(1))"
}

function epy {
    pypath=$(pywhich $1)
    if echo $pypath | grep __init__.py; then
        pypath=$(dirname $pypath)
    fi
    emacsclient -n -c "$pypath"
}

alias pyfmt="python -c 'import sys, autopep8; print(autopep8.fix_code(sys.stdin.read(), options=dict(aggressive=3, max_line_length=120)))'"

# virtualenv
alias wo=workon

# clojure/clojurescript
alias clojure='java -cp cljs.jar:src clojure.main'

alias xsel='xclip -sel clip'

alias normdir='cd $(readlink -f $(pwd))'

alias space='du -s * | sort -g'

function textwrap {
    width=${1:-72}
    python3 -c "import textwrap, sys, re; \
                nl = chr(10); sp = chr(32); qu = chr(34); sl = chr(92); \
                W = type('CommaWrap', (textwrap.TextWrapper,), {}); \
                wp = r'[\\w!{}\'&.,?]'.format(qu); lt = r'[^\\d\\W]'; \
                wordsep_re = r'''
                    ( # any whitespace
                      \\s+ \
                    | # em-dash between words
                      (?<=%(wp)s) -{2,} (?=\\w)
                    | # word, possibly hyphenated
                      \\S+? (?:
                        # hyphenated word
                          -(?: (?<=%(lt)s{2}-) | (?<=%(lt)s-%(lt)s-))
                          (?= %(lt)s -? %(lt)s)
                        | # end of word
                          (?=\\s|\\Z)
                        | # em-dash
                          (?<=%(wp)s) (?=-{2,}\\w)
                        | # comma
                          ,
                        )
                    )''' % {'wp': wp, 'lt': lt}; \
                W.wordsep_re = re.compile(wordsep_re, re.VERBOSE); \
                print((nl+nl).join([ \
                    nl.join(line if i == 0 else sp*2 + line \
                            for (i, line) in enumerate(W(width=$width).wrap(para))) \
                    for para in sys.stdin if para.strip()]))"
}

# If you don't need to split on commas, you can use this simpler version:
# function textwrap {
#     width=${1:-72}
#     python3 -c "import textwrap, sys, re; \
#                 nl = chr(10); sp = chr(32); \
#                 print((nl+nl).join([ \
#                     nl.join(line if i == 0 else sp*2 + line \
#                             for (i, line) in enumerate(textwrap.wrap(para, width=$width))) \
#                     for para in sys.stdin if para.strip()]))"
# }

function cppath {
    file=$1
    echo -n $(readlink -f $file) | xclip -sel clip
}

alias dux='du -sc * | sort -g'
# which emacs25 > /dev/null && alias emacs=emacs25
# which emacsclient25 > /dev/null && alias emacsclient=emacsclient25

function escratch {
    tmpnam=$(mktemp "$@")
    cat | tee $tmpnam
    emacsclient -n -c $tmpnam
}

alias today='date +%Y-%m-%d'
alias yesterday='date --date=@$(($(date +%s) - 86400)) +%Y-%m-%d'
alias tomorrow='date --date=@$(($(date +%s) + 86400)) +%Y-%m-%d'
alias now='date +%Y-%m-%dT%H:%M:%S'

export VENV_LOC="$HOME/.venv"
export DEFAULT_VENV=ladybug
function set_venv {
    name=$1
    echo $name > $VENV_LOC
    workon $name
}

function venv {
    name=$1
    if [[ "$name" != "" ]]; then
       set_venv $name
    else
        cat $VENV_LOC 2> /dev/null || echo $DEFAULT_VENV
    fi
}

function pyan {
    output=$HOME/tmp/pyan.dot
    python pyan3 "$@" --dot --colored > \
           $output && dot $output  -Tpng -O && gwenview ${output}.png
}

function set_ipv6 {
    state=$1
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=$state
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=$state
}

alias pudb='python3 -m pudb.run'

alias ungron='gron --ungron'

function tomp3 {
    src=$1
    dest=${src%.*}.mp3
    ffmpeg -i "$src" -f mp3 -ab 192000 -vn "$dest"
}

alias normj='jq -S .'

alias ytdl=youtube-dl

alias k=kubectl
function sshpod {
    podname=$1
    kubectl -A exec -ti $podname -- /bin/bash
}

function gronall {
    for path in "$@"; do
        gron $path | sed -e "s|^|${path}:|"
    done
}

function gui {
    cmd=$1
    shift
    if [[ -n "${BASH_ALIASES[$cmd]}" ]]; then
        cmd="${BASH_ALIASES[$cmd]}"
    fi
    echo nohup $cmd "$@" \> /dev/null \& disown
    nohup $cmd "$@" > /dev/null &
    disown
}

# join csv cells with a space and print each line
alias decsv="python -c 'import csv, sys; print(chr(10).join(chr(9).join([item.replace(chr(10), chr(0x21b5)) for item in line]) for line in csv.reader(sys.stdin)))'"
alias stripdate="sed -e 's/^[0-9]\+-[0-9]\+-[0-9]\+ \+//'"

alias chrome=google-chrome


function aratest {
    files=$(git diff --staged --name-only; git diff origin/staging..HEAD --name-only)
    # radon cc --min C --show-complexity --total-average --show-closures $files
    radon cc --show-complexity --total-average --show-closures $files
}


alias mypy='mypy --ignore-missing-imports'

function reveal_type {
    module=$1
    attr=$2
    import_item=${attr%%.*}
    mypy --ignore-missing-imports <(echo "from $module import $import_item; reveal_type($attr)")
}

alias kmk='kubectl config use-context minikube'
alias deact=deactivate

alias htmlize='pygmentize -f html'


function mvpath {
    # move a file into a directory while recreating its relative path
    # for example, mvpath a/b/c.txt otherdir will move the file to
    # otherdir/a/b/c.txt
    # If the first argument is --git then this will do git mv instead of mv
    if [[ $1 == "--git" ]]; then
        shift
        mvcmd="git mv"
    else
        mvcmd="mv"
    fi
    dest=${@:$#}
    while [[ $# -gt 1 ]]; do
        src=$1
        shift
        full_dest="$dest/$src"
        mkdir -p $(dirname $full_dest)
        echo "$src -> $full_dest"
        if [[ -d $src ]]; then
            mkdir -p $full_dest
        else
            $mvcmd $src $full_dest
        fi
    done
}
