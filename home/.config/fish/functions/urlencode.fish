function urlencode
	ruby -nr uri -e "puts URI.encode \$_.chomp" $argv;
end
