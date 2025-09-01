# Alias definitions.

alias 'ps?'='ps aux | grep -i '
#alias findname='findname () { find -iname "*$1*"; }; findname'
alias fname='find -name'
alias ipy3=ipython3
alias ipy=ipython
alias bpy=bpython3
alias bpy2=bpython

alias pyecho="python -c 'import sys; print(sys.argv[1:])'"

# ecl=emacsclient
# if which emacs27 > /dev/null; then
#      alias emacs=emacs27
#      alias emacsclient=emacsclient27
#      ecl=emacsclient27
# fi
ecl=/snap/bin/emacs.emacsclient
alias emacsclient=$ecl

ebase="$ecl -n -c -a ''"
alias emacs="/snap/bin/emacs"
alias emacsclient="$ecl"
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
alias SETKB=setkb
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
      print(json.dumps(tomli.loads(sys.stdin.read()), indent=2))'"

alias pretty_xml="python -c 'import sys; from xml.dom.minidom import parse; \
      print(parse(sys.stdin).toprettyxml(indent=chr(32)*4))'"

alias rnd="python3 -c 'import random, sys; print(random.choice(sys.argv[1:]))'"
alias rndchars="strings /dev/urandom | grep -o '[A-Za-z0-9]' | head" # | tr -d "\n"
alias rndid="python3 -c 'import random, string, sys; n = int(sys.argv[1]) if len(sys.argv) > 1 else 5; print(str().join(random.choice(string.ascii_lowercase) for _ in range(n)))'"
alias rndvenv="mkvirtualenv \$(rndid) -p \$(readlink -f \$(pyenv which python))"

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
    name=$1
    if [[ -z $name ]]; then
        args=""
    elif [[ $name = *.* ]]; then
        template=${name%.*}
        if [[ -z $template ]]; then
            template=""
        else
            template=${template}.XXXX
        fi
        ext=${name##*.}
        args="${template} --suffix=.${ext}"
    else
        args=${name}.XXXX
    fi
    tmpnam=$(mktemp $args)
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
    pyan3 "$@" --dot --colored > \
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
alias kpf="kubectl port-forward"
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

alias testpod='kubectl run testpod-adam-$(tr -dc a-z0-9 < /dev/urandom | head -c 5) -ti --rm --image=ubuntu:latest -- bash'

alias quoteargs="python -c 'import sys, shlex; print(shlex.join(sys.argv[1:]))'"

alias pyfuncs="sed -ne ':s;/def /{/[^:]$/{N;T s};G;p}'"

alias mem='/home/adam/media/src/dotfiles/scripts/mem.sh'

alias exc='xsel -o | jq -r .exc_info'

function shrink {
    filename=$1
    basename=${filename%.*}
    echo -n "${filename}: "
    identify -format "%w x %h\n" "$filename"
    convert "$filename" -resize 25% -quality 80 "${basename}.sm.jpg"
}


alias yt-email='yt-dlp --cookies-from-browser firefox:heo7qf7v.email'


function tomp3 {
    fn=$1
    bitrate=32
    lame --preset $bitrate "$fn" "${fn%.*}.${bitrate}kbs.mp3"
}


function ripaudio {
    fn=$1
    mplayer -ao pcm:fast:file="${fn%.*}.wav" -vo null -vc null "$fn"
}

# alias wardays="python -c 'import datetime as dt; print(dt.datetime.now() - dt.datetime(2023, 10, 7, 6, 30))'"
alias wardays="python -c 'import datetime as dt; days=dt.datetime.now() - dt.datetime(2023, 10, 7, 6, 30); print(days.days + days.seconds/86400)'"


alias pyeval="python -c 'import sys;print(eval(sys.stdin.read()))'"


function pychecktype {
    target=$1
    module=${target%.*}
    name=${target##*.}
    mypy <(echo "from ${module} import ${name}; reveal_type(${name})")
}

alias tsv2csv='python -c "import csv, sys; r=csv.reader(sys.stdin, dialect=\"excel-tab\"); w=csv.writer(sys.stdout); d=list(r); w.writerows(d)"'


alias susp='systemctl suspend && xsecurelock'


function randwords {
    words=$(echo $RANDOM % 27 + 17 | bc)
    existing_files=$(find . -type f | wc -l )
    if (( $RANDOM < ( 32767 * $existing_files / ( $existing_files + 100 ) ) )); then
        echo old
        filename=$(ls | shuf -n 1)
    else
        echo new
        filename=$(lorem_text --words 1)
    fi
    echo filename=$filename
    lorem_text --words $words | fold -sw 79 >> $filename
}


function checkquine {
    source=$1
    case $source in
        *.py)
            cmd="python3 $source"
        ;;
        *.js)
            cmd="node $source"
        ;;
        *.hs)
            ghc $source
            cmd="${source%*.hs}"
        ;;
        *.rb)
            cmd="ruby $source"
        ;;
        *.rs)
            out="${source%*.rs}"
            rustc -o $out $source
            cmd="$out"
        ;;
        *)
            shift
            cmd="$@"
        ;;
    esac
    diff -asu $source <($cmd)
}

function csv2json {
    python -c '
import csv
import json
import sys

reader = csv.reader(sys.stdin)
headers = next(reader)
for line in reader:
    print(json.dumps(dict(zip(headers, line))))
'
}

function addtskey {
    python -c '
import json
import sys
import time
from datetime import datetime


for line in sys.stdin:
    data = json.loads(line)
    if data["created"]:
        key = float(data["created"])
    else:
        ts = datetime.fromisoformat(data["@timestamp"].rstrip("Z"))
        key = time.mktime(ts.utctimetuple()) + 60*60*2 + ts.microsecond/1e6
    data["key"] = key
    print(json.dumps(data))
'
}

function sortjson {
    field=$1
    python -c '
import sys
import json

field = sys.argv[1]
lines = list(sys.stdin)
lines.sort(key=lambda data: json.loads(data)[field])
print("".join(lines))
' "$field"

}


# grep unicode character names and print all matches
alias unigrep='python -c "
import re, sys, unicodedata
keys = [re.compile(arg, re.I) for arg in sys.argv[1:]]
default = str()
dotted_circle = chr(0x25cc)
for i in range(1114111):
    c = chr(i)
    if all(key.search(name := unicodedata.name(c, default)) for key in keys):
        d = dotted_circle + c if unicodedata.combining(c) else c
        print(d+chr(0x2066), hex(i), i, name)
"'


function mkarch {
    # create a tar ball out of a file or directory with a progress bar
    SRC=$1
    DEST=${2:-${SRC}.tar.gz}
    SIZE=$(du -sk "$SRC" | cut -f1)
    tar cf - "$SRC" | pv -p -s ${SIZE}k | gzip -c > "$DEST"
}

alias showargs='python -c "import sys; print(sys.argv[1:])"'

alias pck='poetry check --lock'
alias plk='poetry lock --no-update'
alias relock='git checkout --ours poetry.lock && poetry lock && git add poetry.lock'


alias nudenet='docker run -it -p8080:8080 ghcr.io/notai-tech/nudenet:latest'
# Use as:
# curl -sF f1=@"images.jpeg" "http://localhost:8080/infer"
function nudeclass {
  curl -sF f1=@"$1" "http://localhost:8080/infer"
}
# https://github.com/notAI-tech/NudeNet

alias killco="pgrep 'Isolated Web Co' | tail | xargs kill"


function responsibility {
    # Defaults
    regex='.py$'
    grepexpr='raizen'

    # reset getopts index so the function can be called multiple times in the same shell
    OPTIND=1

    # Parse options: -r regex -g grepexpr
    while getopts ":r:g:" opt; do
        case "$opt" in
            r) regex="$OPTARG" ;;
            g) grepexpr="$OPTARG" ;;
            \?) echo "Usage: responsibility [-r regex] [-g grepexpr]" >&2; return 2 ;;
        esac
    done
    shift $((OPTIND - 1))

    # Allow positional overrides for convenience: responsibility <regex> <grepexpr>
    if [ $# -ge 1 ]; then regex="$1"; fi
    if [ $# -ge 2 ]; then grepexpr="$2"; fi

    # Collect blame for files matching the regex
    fullblame=$(git ls-files | grep "$regex" | xargs -L1 git blame 2>/dev/null || true)

    # Count matches and total lines; handle empty result safely
    mine=$(grep -i "$grepexpr" <<< "$fullblame" | wc -l)
    all=$(wc -l <<< "$fullblame" | tr -d ' ')

    if [ -z "$all" ] || [ "$all" -eq 0 ]; then
        python -c "print(0.0)"
    else
        python -c "import sys; a=int(sys.argv[1]); b=int(sys.argv[2]); print(a/b if b else 0.0)" "$mine" "$all"
    fi
}
