# TODO: rvm, nvm, google cloud sdk, virtualenvwrapper

alias jenkins 'ssh -L8080:localhost:8080 adam@c8-ci.colabo.com'
alias ipy ipython2
alias ipy3 'test -n "$VIRTUAL_ENV"; and deactivate; ipython3'

set -gx CDPATH $CDPATH $HOME/src/genie/branches $HOME/src/genie/worktrees
set -gx GENIE_ENV dev
set -gx FIREBASE_PROJECT_ID dev-adam-12bd0

function runsvc -a svc
    pushd ./$svc
    env GENIE_SERVICE_NAME=$svc ./$svc
    popd
end

# workon genie  # XXX
