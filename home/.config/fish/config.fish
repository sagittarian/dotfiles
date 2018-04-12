set -gx EDITOR emacsclient
set -gx PYTHONPATH $HOME/python $PYTHONPATH
set -gx PATH $HOME/bin $HOME/.local/bin $PATH
set -gx CDPATH . .. $HOME $HOME/src $CDPATH
set -gx TERMINAL (which terminator)


# TODO:
# unhist
# lmv (doesn't work properly)
# virtualenvwrapper and wo=workon
# alias emacs to emacs25 if that exists
