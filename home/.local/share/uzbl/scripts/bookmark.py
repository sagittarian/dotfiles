#!/usr/bin/env python3

import argparse
import os
import re
import sys

DEFAULT_OUT = os.path.expanduser('~/src/org/bookmarks')

class AddTagTransform:
    def __init__(self, tag, test):
        self.tag = tag
        self.test = test

    def __call__(self, bmark):
        if self.tag not in bmark.tags and self.test(bmark):
            bmark.tags.append(self.tag)

class Bookmark:

    transformations = []
    hashtag = '#'

    @classmethod
    def transform(cls, func):
        cls.transformations.append(func)
        return func

    def __init__(self, url, tags, title):
        self.url = url
        self.tags = tags
        self.title = title

    def apply_transforms(self):
        for xfunc in self.transformations:
            xfunc(self)

    def format_line(self):
        tags = ' '.join(self.hashtag + t for t in self.tags)
        line = "{url} {tags} {title}".format(
            url=self.url, title=self.title, tags=tags)
        return line

lesswrong = AddTagTransform('lw',
                            lambda b: 'lesswrong.com' in b.url or
                            re.search('less[-_ ]?wrong', b.title, re.I))
Bookmark.transform(lesswrong)


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
                        '(regarding environment, etc).  '
                        'Default depends on whether this appears to be being '
                        'called from a uzbl config directory.')
    parser.add_argument('--nouzbl', '--no-uzbl',
                        action='store_false', dest='uzbl',
                        help='assume this is NOT being called from uzbl')
    parser.add_argument('--stdout', action='store_true', default=False,
                        help='print the result to stdout')

    args = parser.parse_args()

    if args.uzbl:
        args.title = args.title or os.environ.get('UZBL_TITLE', '')
        args.url = args.url or os.environ.get("UZBL_URI", '')

    args.tags = args.tags.strip().replace(' ', '-')
    args.tags = [t for t in args.tags.split(',')] if args.tags else []

    return args

def get_bmark_from_args(args):
    bmark = Bookmark(args.url, args.tags, args.title)
    bmark.apply_transforms()
    return bmark

def main():
    args = get_args()
    bmark = get_bmark_from_args(args)
    line = bmark.format_line()
    if args.stdout:
        print(line, file=sys.stdout)
    else:
        with open(DEFAULT_OUT, 'a') as fp:
            print(line, file=fp)

if __name__ == '__main__':
    main()
