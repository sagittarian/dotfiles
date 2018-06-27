alias jenkins='ssh -L8080:localhost:8080 adam@c8-ci.colabo.com'
alias ipy=ipython2
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
    PYTHONPATH=./src/python/$pkg:../src/python/$pkg:$PYTHONPATH
done
PYTHONPATH=./oms_svc/src/python/genie_oms:$PYTHONPATH
PYTHONPATH=./test/src/python/genie_test/genie_test:../test/src/python/genie_test/genie_test:$PYTHONPATH
export PYTHONPATH

export GENIE_ENV=dev

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

alias lorem="python -c 'import random; from statlorem import ipsum; print(ipsum(\"scifi\", 1, random.randrange(5, 19)))' | tee >(cat 1>&2) | xsel"
alias monsvc='watch "ps aux | grep -v virtualenv | grep [s]vc; echo total services: \$(ps aux | grep -v virtualenv | grep [s]vc | wc -l)"'
alias newjira="jira-cli new -v --jira-url https://jira.colabo.com --project GEN --assignee adam --description '' --type Task --priority medium"
alias migrate='echo "I want to run migrations on env: DEV env_id:ADAM__AT__ANTHIA" | devops/migrations/do-db-migrate -H localhost -p 5432 -d genie_dev'

function geniecat {
    cat "$@" | jq -r '.levelname + " " + .["@timestamp"] + " " + .message'
}

export GENIE_GLOBAL_LOG_LEVEL=info

# source $HOME/.virtualenvs/geniedev/bin/activate
workon geniedev


# docker run -v $(readlink -f ./conf):/genie/services/conf -v /var/log/genie:/var/log/genie -ti --entrypoint /bin/bash adam-genie-test
