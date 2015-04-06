#!/usr/bin/env python3

import argparse
import os
import sys

DEFAULT_OUT = os.path.expanduser('~/src/org/bookmarks')

def get_args():
    is_uzbl = 'uzbl' in sys.argv[0]

    parser = argparse.ArgumentParser(description='Add a link to the bookmark list.')
    parser.add_argument('--title', metavar='TITLE', type=str, default='',
                        help='the title for the bookmark')
    parser.add_argument('--url', metavar='URL', type=str, default='',
                        help='the url for the bookmark')
    parser.add_argument('--tags', metavar='TAGS', type=str, default='',
                        help='the (comma-separated) tags for the bookmark')
    parser.add_argument('--uzbl', default=is_uzbl, action='store_true',
                        help='assume this is being called from uzbl '
                        '(regarding environment, etc).'
                        'Default depends on whether this appears to be being '
                        'called from a uzbl config directory.')
    parser.add_argument('--nouzbl', action='store_false', dest='uzbl',
                        help='assume this is NOT being called from uzbl')

    args = parser.parse_args()

    if args.uzbl:
        args.title = args.title or os.environ['UZBL_TITLE']
        args.url = args.url or os.environ["UZBL_URI"]

    args.tags = args.tags.strip().replace(' ', '-')
    args.tags = ('#' + t for t in args.tags.split(',')) if args.tags else ''

    return args

def main():
    args = get_args()
    line = "{url} {tags} {title}".format(
        url=args.url, title=args.title, tags=' '.join(args.tags))
    with open(DEFAULT_OUT, 'a') as fp:
        print(line, file=fp)

if __name__ == '__main__':
    main()
