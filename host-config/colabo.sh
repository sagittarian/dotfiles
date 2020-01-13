alias jenkins='ssh -L8080:localhost:8080 adam@c8-ci.colabo.com'
# alias pgprod='ssh -L15432:localhost:15432 adam@c8-pr1.colabo.com'
alias pgprod='ssh -L15432:postgresql-cluster-prod-a-node-0:5432 adam@c8-pr1.colabo.com'
alias pgst2='ssh -L25432:postgresql-cluster-st2-node-0:5432 adam@c8-st2.colabo.com'
alias ipy=ipython
alias ipy3='[ -n "$VIRTUAL_ENV" ] && (python --version |& grep "Python 2" > /dev/null) && deactivate; ipython3'

export BUZZ_REPO=$HOME/src/buzz/worktrees/moon
export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/src/buzz/devops/ansible/vault-password

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
# export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export CDPATH=$CDPATH:$HOME/src/genie/worktrees:$HOME/src/buzz/worktrees

export GENIE2_VIRTUALENV=geniedev
export GENIE3_VIRTUALENV=genie3
export GENIE_VIRTUALENV=$GENIE2_VIRTUALENV
export BUZZ2_VIRTUALENV=buzz2
export BUZZ3_VIRTUALENV=buzzdev
export BUZZ_VIRTUALENV=$BUZZ3_VIRTUALENV
alias genie='set_venv $GENIE_VIRTUALENV'
alias genie2='set_venv $GENIE2_VIRTUALENV && export GENIE_VIRTUALENV=$GENIE2_VIRTUALENV'
alias genie3='set_venv $GENIE3_VIRTUALENV && export GENIE_VIRTUALENV=$GENIE3_VIRTUALENV'
alias buzz='set_venv $BUZZ_VIRTUALENV'
alias buzz2='set_venv $BUZZ2_VIRTUALENV && export BUZZ_VIRTUALENV=$BUZZ2_VIRTUALENV'
alias buzz3='set_venv $BUZZ3_VIRTUALENV && export BUZZ_VIRTUALENV=$BUZZ3_VIRTUALENV'


for pkg in genie pycase; do
    PYTHONPATH=./src/python/$pkg:$PYTHONPATH
done
# PYTHONPATH=./test/src/python/genie_test:$PYTHONPATH
PYTHONPATH=./oms_svc/src/python/genie_oms:$PYTHONPATH
PYTHONPATH=./test/src/python/genie_test/genie_test:$PYTHONPATH
PYTHONPATH=./history_svc/src/python/genie_history:$PYTHONPATH
PYTHONPATH=./carrier_svc/src/python/genie_carriers:$PYTHONPATH
PYTHONPATH=./email_reader_svc/src/python/genie_email_reader:$PYTHONPATH
PYTHONPATH=./payment_svc/src/python/genie_payment:$PYTHONPATH
PYTHONPATH=./agent_svc/src/python/genie_agent:$PYTHONPATH
PYTHONPATH=./date_logic_svc/src/python/genie_date_logic:$PYTHONPATH

# tmp till buzz settles down hopefully
# PYTHONPATH=./watershed_svc/src/watershed:./config_svc/src/buzz_config:$PYTHONPATH
# PYTHONPATH=./agent_svc/src/agent:./config_svc/src/buzz_config:$PYTHONPATH
# PYTHONPATH=./customer_svc/src/buzz_customer:./agent_api_svc/src/buzz_agent_api:$PYTHONPATH
# PYTHONPATH=./conversation_svc/src/buzz_conversation:$PYTHONPATH
# PYTHONPATH=./src/buzz:./src/pycase:./test/src:$PYTHONPATH
# for d in $(/home/adam/src/buzz/dev/get-services | cut -d' ' -f 2); do
#     PYTHONPATH=./$d/src:$PYTHONPATH
# done

PYTHONPATH=./src/buzz:./src/pycase:./test/src:$PYTHONPATH
pushd $BUZZ_REPO > /dev/null
for svc in $($WORKON_HOME/buzzdev/bin/python $BUZZ_REPO/dev/get-services | cut -d' ' -f 2); do
    PYTHONPATH=./$svc/src:../$svc/src:$PYTHONPATH
done
popd > /dev/null


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
export AUTH0_CLIENT_ID="hCDpeOQPBeOd08C5Ddx08R8Q68ZZzBcV"
export PROD=c8-pr1.colabo.com
export ST2=c8-st2.colabo.com
export ST1=c8-st1.colabo.com
export JENKINS=c8-ci.colabo.com

read -r -d '' UNRUN <<'EOF'
import re, subprocess; from buzz.config import get_config
svcs = [svc for (svc, info) in get_config()["service_discovery"]["services"].items() if info["enabled"]]
running = [x.strip() for x in re.findall(
    r"[^/]+$",
    subprocess.check_output("ps aux | grep -v virtualenv | grep [s]vc", shell=True).decode("utf-8"),
    flags=re.MULTILINE)];
print("\n".join(set(svcs) - set(running)))
EOF
# alias unrun="(cd ~/src/genie/worktrees/py3 && python -c '$UNRUN')"
alias unrun="(cd $BUZZ_REPO && $WORKON_HOME/buzzdev/bin/python -c '$UNRUN')"

alias lorem="python -c 'import random; from statlorem import ipsum; print(ipsum(\"scifi\", 1, random.randrange(5, 19)))' | tee >(cat 1>&2) | xsel"
alias monsvc='watch "ps aux | grep -v virtualenv | grep [s]vc; echo total services: \$(ps aux | grep -v virtualenv | grep [s]vc | wc -l)"'
# alias newjira="jira-cli new -v --jira-url https://jira.colabo.com --project GEN --assignee adam --description '' --type Task --priority medium"
alias createjira=/home/adam/src/genie/tools/create-jira.py
function migrate {
    magic_str="I want to run migrations on env: %s env_id:ADAM__AT__ANTHIA"
    orig_env=$GENIE_ENV
    export GENIE_ENV=dev
    printf '$magic_str' DEV | devops/migrations/do-db-migrate -H localhost -p 5432 -d genie_dev;
    export GENIE_ENV=test
    printf '$magic_str' TEST | devops/migrations/do-db-migrate -H localhost -p 5432 -d genie_test
    export GENIE_ENV=$orig_env
}

function _grablog {
    project=$1
    svc=$2
    host=${3:-prod}
    echo svc is $svc and host is $host
    destdir=$(date +%Y-%m-%d)
    if [ "$(basename $(pwd))" = "$(date +%Y-%m-%d)" ]; then
        destdir=.
    else
        destdir="./$destdir"
        mkdir -p $destdir
    fi
    rsync --progress -avz "${host}:/var/log/${project}/${svc}*.log*" $destdir
}
alias grablog="_grablog buzz"
alias genielog="_grablog genie"

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
export BUZZ_GLOBAL_LOG_LEVEL=info

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

eval $(cd ~/src/buzz && $WORKON_HOME/buzzdev/bin/python -c "from buzz.config import get_config
for s, d in get_config()['service_discovery']['services'].items(): print('{}_PORT={}'.format(s.upper(), d.get('port', '')))")

alias greplog='python3 /home/adam/src/buzz/tools/greplog.py -v -L "genie\\.kafka\\.access$"'
alias lintkill='while pkill -f pylint; do sleep 1; done'
# alias cube='genie-cube/run-genie-cube'
# alias bcube='buzz-cube/run-buzz-cube'
alias cube='if [ -e genie-cube ]; then genie-cube/run-genie-cube; else buzz-cube/run-buzz-cube; fi'
alias kafdrop="java -jar $HOME/src/Kafdrop/target/kafdrop-2.0.6.jar --zookeeper.connect=127.0.0.1:2181"
alias kafka='docker run --rm -p 12181:2181 -p 19092:9092 \
    --env ADVERTISED_HOST=127.0.0.1 --env ADVERTISED_PORT=19092 spotify/kafka'

function stest {
    # run service tests more easily
    svcname=${1}_svc
    shift
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

# tail log
# tail -f /var/log/genie/tax_svc-1.log | jq -r '"'$(tput setaf 1; tput bold)'" + .["@timestamp"] + " " + .level + "'$(tput sgr0)'\n  " + .message'


# unset PYTHONPATH
# export BUZZ_VIRTUALENV=bt
# deactivate || true
# rmvirtualenv $BUZZ_VIRTUALENV || true
# workon $BUZZ_VIRTUALENV
pyenv shell 3.7.3

export PYTHONASYNCIODEBUG=1
export AUTH0_CLIENT_ID=hCDpeOQPBeOd08C5Ddx08R8Q68ZZzBcV


function create_gcloud_instance {
    name=$1
    shift
    datadiskname=${name}-datadisk
    image=ubuntu-1804-bionic-v20191021
    imagefam=ubuntu-1804-lts
    imageproj=ubuntu-os-cloud
    echo gcloud compute instances create $name \
       --image-family $imagefam \
       --image-project $imageproj \
       --boot-disk-size 30GB \
       --create-disk=name=$datadiskname,size=200GB,device-name=$name-datadisk,auto-delete=no \
       --zone us-central1-a \
       --machine-type n1-standard-4 \
       --tags=https-server \
       "$@"
}

alias py3='workon py3 && ipython'
