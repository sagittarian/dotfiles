function cppath --argument name
	readlink -f $name | xclip -sel clip
end
