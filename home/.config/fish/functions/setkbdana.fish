function setkbdana
	setxkbmap -layout 'us,il' -option ''; and setxkbmap -layout 'us,il' -option grp:shifts_toggle $argv;
end
