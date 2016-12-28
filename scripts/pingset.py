#!/usr/bin/env python3

'''Count the pings in a given tagtime log file'''

import collections
import re

def stripparens(line):
    result = []
    pairs = ('{}', '()', '[]')
    closers = dict(pairs)
    openers = dict((p[1], p[0]) for p in pairs)
    state = []
    start = 0
    for i in range(len(line)):
        if line[i] in closers:
            if not state:
                result.append(line[start:i])
            state.append(line[i])
        elif line[i] in openers and state and state[-1] == openers[line[i]]:
            state.pop()
            if not state:
                start = i+1
    return ''.join(result)

def itags(line):
    '''Return an iterator over the tags in the line'''
    line = stripparens(re.match(r'\d+\s+(.*)', line).group(1))
    return (m.group(0) for m in re.finditer(r'\S+', line))

def countall(lines):
    result = collections.Counter()
    for line in lines:
        result.update(itags(line))
    return result

def main():
    import sys
    with open(sys.argv[1]) as f:
        result = countall(f)
    for (tag, count) in result.most_common():
        print('{}: {}'.format(tag, count))

if __name__ == '__main__':
    main()


