alias jenkins='ssh -L8080:localhost:8080 adam@c8-ci.colabo.com'
alias ipy=ipython2
alias ipy3='[ -n "$VIRTUAL_ENV" ] && deactivate; ipython3'

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

export GENIE_ENV=dev

function runsvc {
    svc=$1
    pushd ./$svc
    GENIE_SERVICE_NAME=$svc ./$svc
    popd
}

export FIREBASE_PROJECT_ID=dev-adam-12bd0

# source $HOME/.virtualenvs/geniedev/bin/activate
workon geniedev
