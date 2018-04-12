function showpypath --argument modname
	python -c "import re, $modname; print(re.search(r\"([^']+.py)c?'>\", str($modname)).group(1))"
end
