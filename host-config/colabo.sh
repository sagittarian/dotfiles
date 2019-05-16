alias jenkins='ssh -L8080:localhost:8080 adam@c8-ci.colabo.com'
# alias pgprod='ssh -L15432:localhost:15432 adam@c8-pr1.colabo.com'
alias pgprod='ssh -L15432:postgresql-cluster-prod-a-node-0:5432 adam@c8-pr1.colabo.com'
alias pgst2='ssh -L25432:postgresql-cluster-st2-node-0:5432 adam@c8-st2.colabo.com'
alias ipy=ipython
alias ipy3='[ -n "$VIRTUAL_ENV" ] && (python --version |& grep "Python 2" > /dev/null) && deactivate; ipython3'

export NVM_DIR="/home/adam/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# path and command completion for the Google Cloud SDK
if [ -f '/home/adam/bin/google-cloud-sdk/path.bash.inc' ]; then
    source '/home/adam/bin/google-cloud-sdk/path.bash.inc'
fi
if [ -f '/home/adam/bin/google-cloud-sdk/completion.bash.inc' ]; then
    source '/home/adam/bin/google-cloud-sdk/completion.bash.inc'
fi

# RVM
# Add RVM to PATH for scripting.
# Make sure this is the last PATH variable change.
# export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


export CDPATH=$CDPATH:$HOME/src/genie/branches:$HOME/src/genie/worktrees
for pkg in genie pycase; do
    PYTHONPATH=./src/python/$pkg:$PYTHONPATH
done
PYTHONPATH=./oms_svc/src/python/genie_oms:$PYTHONPATH
PYTHONPATH=./test/src/python/genie_test/genie_test:$PYTHONPATH
PYTHONPATH=./history_svc/src/python/genie_history:$PYTHONPATH
PYTHONPATH=./carrier_svc/src/python/genie_carriers:$PYTHONPATH
PYTHONPATH=./email_reader_svc/src/python/genie_email_reader:$PYTHONPATH
PYTHONPATH=./payment_svc/src/python/genie_payment:$PYTHONPATH
export PYTHONPATH


export PYTHONPATH

export GENIE_ENV=dev
export GENIE_CONFIG_FOLDER=./conf

function runsvc {
    svc=$1
    pushd ./$svc
    GENIE_SERVICE_NAME=$svc ./$svc
    popd
}

export FIREBASE_PROJECT_ID=dev-adam-12bd0
export PROD=c8-pr1.colabo.com
export ST2=c8-st2.colabo.com
export ST1=c8-st1.colabo.com
export JENKINS=c8-ci.colabo.com

read -r -d '' UNRUN <<'EOF'
import re, subprocess; from genie.config import get_config
svcs = get_config()["service_discovery"]["services"]
running = [x.strip() for x in re.findall(
    r"[^/]+$",
    subprocess.check_output("ps aux | grep -v virtualenv | grep [s]vc", shell=True),
    flags=re.MULTILINE)];
print("\n".join(set(svcs) - set(running)))
EOF
alias unrun="(cd ~/src/genie && python -c '$UNRUN')"

alias lorem="python -c 'import random; from statlorem import ipsum; print(ipsum(\"scifi\", 1, random.randrange(5, 19)))' | tee >(cat 1>&2) | xsel"
alias monsvc='watch "ps aux | grep -v virtualenv | grep [s]vc; echo total services: \$(ps aux | grep -v virtualenv | grep [s]vc | wc -l)"'
# alias newjira="jira-cli new -v --jira-url https://jira.colabo.com --project GEN --assignee adam --description '' --type Task --priority medium"
alias createjira=/home/adam/src/genie/tools/create-jira.py
alias migrate='echo "I want to run migrations on env: DEV env_id:ADAM__AT__ANTHIA" | devops/migrations/do-db-migrate -H localhost -p 5432 -d genie_dev'

function grablog {
    svc=$1
    destdir=$(date +%Y-%m-%d)
    if [ "$(basename $(pwd))" = "$(date +%Y-%m-%d)" ]; then
        destdir=.
    else
        destdir="./$destdir"
        mkdir -p $destdir
    fi
    rsync --progress -avz "prod:/var/log/genie/${svc}*.log*" $destdir
}

alias synclogs='rsync -avz "prod:/var/log/genie/*log*" .'

alias seelog='jq -r '"'"'.["@timestamp"] + " " + .levelname + " " + .message + "
" + .exc_info'"'"

function prod {
    port=$1
    shift
    url=$1
    shift
    cmd="curl -s 'http://localhost:$port/api/v1/$url' $@"
    # echo $cmd
    ssh prod "$cmd" | jq .
}

alias striplogname="sed -re 's/^[a-z_]+-[0-9]+\.log(\.[0-9]+)?://'"

export GENIE_GLOBAL_LOG_LEVEL=info

# alias ccfmt="python -c \"import autopep8, sys, re; \
#        print('\n'.join(re.sub(r'\b[A-Z]\w+\(.*\)$', \
#                               lambda match: autopep8.fix_code(match.group(0), \
#                                                               options=dict(aggressive=3)), \
#                               line) for line in sys.stdin))\""


alias ccfmt="python -c \"import autopep8, sys, re
for line in sys.stdin: print(
    re.sub(r'\b[A-Z]\w+\(.*\)$',
           lambda match: autopep8.fix_code(match.group(0),
                                           options=dict(aggressive=3, max_line_length=120)),
           line.rstrip()))\""


# source $HOME/.virtualenvs/geniedev/bin/activate
export GENIE2_VIRTUALENV=geniedev
export GENIE3_VIRTUALENV=genie3
export GENIE_VIRTUALENV=$GENIE2_VIRTUALENV
export BUZZ2_VIRTUALENV=buzzdev
export BUZZ3_VIRTUALENV=buzz3
export BUZZ_VIRTUALENV=$BUZZ3_VIRTUALENV
alias genie='workon $GENIE_VIRTUALENV'
alias genie2='workon $GENIE2_VIRTUALENV'
alias genie3='workon $GENIE3_VIRTUALENV'
alias buzz='workon $BUZZ_VIRTUALENV'
alias buzz2='workon $BUZZ2_VIRTUALENV'
alias buzz3='workon $BUZZ3_VIRTUALENV'
genie

eval $(cd ~/src/genie && python -c "from genie.config import get_config
for s, d in get_config()['service_discovery']['services'].items(): print('{}_PORT={}'.format(s.upper(), d['port']))")

alias greplog='python /home/adam/src/genie/tools/greplog.py -v -x "Thread #0"'
alias lintkill='while pkill -f pylint; do sleep 1; done'
function stest {
    # run service tests more easily
    svcname=${1}_svc
    shift;
    ./run-service-tests $svcname "$@"
}


function geniecp {
    src=$1
    dest=$2
    path=$3
    prefix=$HOME/src/genie
    if [ "$src" = "genie" ]; then
        src=$prefix
    else
        src=$prefix/worktrees/$src
    fi

    if [ "$dest" = "genie" ]; then
        dest=$prefix
    else
        dest=$prefix/worktrees/$dest
    fi

    cp -vi $src/$path $dest/$path
}

# docker run -v $(readlink -f ./conf):/genie/services/conf -v /var/log/genie:/var/log/genie -ti --entrypoint /bin/bash adam-genie-test
