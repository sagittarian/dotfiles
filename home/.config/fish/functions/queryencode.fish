function queryencode
	ruby -nr uri -e "puts URI.encode_www_form(nil => \$_.chomp)[1..-1]" $argv;
end
