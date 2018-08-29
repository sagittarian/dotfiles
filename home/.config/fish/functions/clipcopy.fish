function clipcopy --argument name
	readlink -f $name | xclip -sel clip
end
