set colabo_config (dirname (status --current-filename))/colabo.fish
test -f $colabo_config; and source $colabo_config
