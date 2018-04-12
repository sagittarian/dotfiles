function rnd
	python3 -c 'import random, sys; print(random.choice(sys.argv[1:]))' $argv;
end
