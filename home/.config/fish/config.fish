set -gx EDITOR emacsclient
set -gx PYTHONPATH $HOME/python $PYTHONPATH
set -gx PATH $HOME/bin $HOME/.local/bin $PATH
set -gx CDPATH . .. $HOME $HOME/src $CDPATH
set -gx TERMINAL (which terminator)


# load additional config for specific hosts
set repo_root (dirname (dirname (dirname (dirname \
    (readlink -f (status --current-filename))))))
set host_config $repo_root/host-config/fish/(hostname).fish
if test -f "$host_config"
    source "$host_config"
end


# TODO:
# unhist
# lmv (doesn't work properly)
# virtualenvwrapper and wo=workon
# alias emacs to emacs25 if that exists
