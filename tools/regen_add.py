#!/usr/bin/env python3

"""
Add delta to address range in a Regenerator config script file.
by Sean Gugler
"""

import re
import sys
import argparse

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument("-v", "--verbose", action="store_true",
                   help="Verbose output.")
    p.add_argument("filename", help="Regenerator config to adjust")
    p.add_argument('-b', '--begin', default='0000', help="Address range begin for adjustment")
    p.add_argument('-e', '--end', default='ffff', help="Address range end for adjustment")
    p.add_argument('-x', '--exclude-text', action="store_true",
                   help="Do not adjust DATA ranges or comments for in-line text")
    p.add_argument('offset', help="Amount to adjust all addresses in range by. Can be negative.")
    return p.parse_args(argv[1:])

def main(argv):
    args = usage(argv)
    run(args.filename, args.begin, args.end, args.offset, args.exclude_text)
    return 0

def run(fname, begin, end, off, exclude_text):
    begin = int(begin, 16)
    end = int(end, 16)
    off = int(off, 16)

    def add(st):
        n = int(st, 16)
        return f'{n+off:04X}' if begin <= n < end else st

    pat = re.compile(r'^(....)-(....)(.*)')
    text = re.compile(r'.... b[\'"]')
    disable = False
    def adjust(line):
        global disable
        if line.startswith(':DATA BYTES'):
            disable = True
            return line
        if any(line.startswith(pre) for pre in(':','Apple','Commodore')):
            disable = False
            return line
        if disable and exclude_text:
            return line
        if text.match(line) and exclude_text:
            return line
        if m := pat.match(line):
            a,b,tail = m.groups()
            a = add(a)
            b = add(b)
            return f'{a}-{b}{tail}\n'
        a,tail = line[:4],line[4:]
        return f'{add(a)}{tail}'

    with open(fname, 'rt') as f:
        lines = map(adjust, f.readlines())
    with open(fname, 'wt') as f:
        f.write(''.join(lines))


if __name__ == '__main__':
    sys.exit(main(sys.argv))
