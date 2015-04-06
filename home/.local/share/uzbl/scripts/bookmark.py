#!/usr/bin/env python3

import argparse
import os
import re
import sys

DEFAULT_OUT_DIR = os.path.expanduser('~/src/org')

class AddTagTransform:
    def __init__(self, tag, test):
        self.tag = tag
        self.test = test
        Bookmark.transform(self)

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

    @staticmethod
    def parsetags(note):
        tags = []
        def replace(m):
            tags.append(m.group(2))
            if not m.group(1) or not m.group(3):
                return ''
            return m.group(1) + m.group(3)
        return tags, re.sub(r'(\s+|^)#(\S+)(\s+|$)', replace, note).strip()

    def __init__(self, url='', tags=(), title='', note=''):
        extratags, note = self.parsetags(note)
        self.url = url
        self.tags = list(tags)
        self.tags.extend(extratags)
        self.title = title
        self.note = note

    def apply_transforms(self):
        for xfunc in self.transformations:
            xfunc(self)

    def format_line(self):
        tags = ' '.join(self.hashtag + t for t in self.tags)
        if not self.title or not self.note:
            rest = self.title or self.note
        else:
            rest = '{title}: {note}'.format(title=self.title, note=self.note)
        line = "{url} {tags} {rest}".format(
            url=self.url, rest=rest, tags=tags)
        return line

lesswrong = AddTagTransform('lw',
                            lambda b: 'lesswrong.com' in b.url or
                            re.search('less[-_ ]?wrong', b.title, re.I))

youtube = AddTagTransform('yt', lambda b: 'youtu' in b.url)


def get_args():
    is_uzbl = 'uzbl' in sys.argv[0]

    parser = argparse.ArgumentParser(description='Add a link to the bookmark list.')
    parser.add_argument('note', type=str, nargs='*', default='',
                        help='A note to add.')
    parser.add_argument('--title', metavar='TITLE', type=str, default='',
                        help='the title for the bookmark')
    parser.add_argument('--url', metavar='URL', type=str, default='',
                        help='the url for the bookmark')
    parser.add_argument('--tags', metavar='TAGS', type=str, default='',
                        help='the (comma-separated) tags for the bookmark.  '
                        'Note also that tags can be added with #hashtags.')
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
    parser.add_argument('--file', metavar='FILE', default='bookmarks',
                        help='The file in {} to write to. (Default: {})'.format(
                            DEFAULT_OUT_DIR, 'bookmarks'))

    args = parser.parse_args()

    if args.uzbl:
        args.title = args.title or os.environ.get('UZBL_TITLE', '')
        args.url = args.url or os.environ.get("UZBL_URI", '')

    args.tags = args.tags.strip().replace(' ', '-')
    args.tags = [t for t in args.tags.split(',')] if args.tags else []

    args.note = ' '.join(args.note)

    return args

def get_bmark_from_args(args):
    bmark = Bookmark(args.url, args.tags, args.title, args.note)
    bmark.apply_transforms()
    return bmark

def main():
    args = get_args()
    bmark = get_bmark_from_args(args)
    line = bmark.format_line()
    if args.stdout:
        print(line, file=sys.stdout)
    else:
        path = os.path.join(DEFAULT_OUT_DIR, args.file)
        with open(path, 'a') as fp:
            print(line, file=fp)

if __name__ == '__main__':
    main()
