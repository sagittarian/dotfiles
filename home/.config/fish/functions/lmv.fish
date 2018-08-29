function lmv --argument src dest
	set fullsource (readlink -fn $src)
	set fulldest (readlink -mn $dest)
	mkdir -p "$dest"; and mv "$src" "$dest"; and ln -s "$fulldest/(basename $src)" "$fullsource"
end
