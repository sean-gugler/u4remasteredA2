#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate .d makefile dependency file from .s source
by Sean Gugler
"""

import sys
import argparse
import os.path
import re

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('input', help="input asm .s source file")
    p.add_argument('output', help="output dependency .d makefile")
    return p.parse_args(argv[1:])

include = re.compile(r'\t.include "(.*)"')

def includes(src):
    for line in src:
        if m := include.match(line):
            yield m.group(1)

def main(argv):
    args = usage(argv)

    with open(args.input, 'rt') as f:
        src = f.readlines()

    base, ext = os.path.splitext(args.input)
    obj = base + '.o'

    deps = ' '.join(f'src/include/{file}' for file in includes(src))

    with open(args.output, 'wt') as out:
        print(f'{obj}: {deps}', file=out)

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
