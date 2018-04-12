function urldecode
	ruby -nr uri -e "puts URI.decode \$_.chomp" $argv;
end
