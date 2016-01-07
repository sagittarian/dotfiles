#!/usr/bin/python

import yaml
import re
import sys

def deunicode(obj):
    if isinstance(obj, dict):
        for key in obj:
            val = deunicode(obj[key])
            del obj[key]
            obj[str(key)] = val
    elif isinstance(obj, list):
        for (i, v) in enumerate(obj):
            obj[i] = deunicode(v)
    elif isinstance(obj, tuple):
        obj = tuple(deunicode(x) for x in obj)
    elif isinstance(obj, unicode):
        obj = str(obj)
    return obj

def yamlize(o, indent='  '):
    result = yaml.dump(deunicode(o))
    print(re.sub('^', indent, result, flags=re.M))

def get_template():
    return {
        'environment': None,
        'report': {'url': ''},
        'tests': {},
        'variables': {'test_var': 1}
    }

def main():
    envstr = sys.stdin.read()
    env = get_template()
    env['environment'] = deunicode(eval(envstr))
    print(yaml.dump(env))

if __name__ == '__main__':
    main()

