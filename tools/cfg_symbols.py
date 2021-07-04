#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Create a linker cfg file with automatic symbols
by Sean Gugler

Concatenates a partial file containing segment definitions
with a generated list of symbols from the .lab file from
another program module.
"""

import sys
import argparse
import re

patLab = re.compile(r'al 00(....) \.([^@].*)')

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('segments', help="input, segment definitions")
    p.add_argument('lab', help="input, .lab file with exported symbols")
    p.add_argument('cfg', help="output, composite .cfg file")
    return p.parse_args(argv[1:])

def main(argv):
    args = usage(argv)

    with open(args.segments, 'rt') as f:
        lines = f.readlines()
    with open(args.lab, 'rt') as f:
        lab = f.readlines()

    lines.append('SYMBOLS {\n')
    for line in lab:
        if m := patLab.match(line):
            addr, sym = m.groups()
            lines.append(f'\t{sym}: type = export, value = ${addr};\n')
    lines.append('}\n')

    with open(args.cfg, 'wt') as f:
        f.write(''.join(lines))


if __name__ == '__main__':
    sys.exit(main(sys.argv))
