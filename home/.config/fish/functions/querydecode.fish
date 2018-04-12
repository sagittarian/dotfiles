function querydecode
	ruby -nr uri -e "puts URI.decode_www_form(61.chr + \$_.chomp).to_h[%{}]" $argv;
end
