#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Refresh a Config script for Regenerator from a list of labels.
by Sean Gugler
"""

import sys
import argparse

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument('-v', '--verbose', action="store_true", help="Verbose output.")
    p.add_argument('-n', '--testonly', action="store_true", help="Do not commit results.")
    p.add_argument('labels', help="File of external labels")
    p.add_argument('config', help="Regenerator Config file to refresh")
    return p.parse_args(argv[1:])

def main(argv):
    args = usage(argv)

    # Read address labels
    with open(args.labels, 'rt') as f:
        lines = f.readlines()
    # labels = {k:v  for line in lines  for k,v in line.split()}
    labels = {line[:4] : line[5:]  for line in lines}

    # Refresh the Config script file
    def refresh(lines):
        new = None
        old = ''
        for line in lines:
            if line == ':USER LABELS\n':
                replace = True
            elif line.startswith(':'):
                replace = False
            elif replace:
                new = labels.get(line[:4])
                if new == '\n':
                    if args.verbose:
                        print(f'DEL:  {line[:-1]}')
                    continue  #delete label
                elif new:
                    old = line[5:]
                    line = line[:5] + new
                    if args.verbose:
                        action = 'REPL' if new != old else 'keep'
                        print(f'{action}: {line[:-1]}')
            yield line
    with open(args.config, 'rt') as f:
        lines = list(refresh(f.readlines()))

    # Write the Config script file
    if not args.testonly:
        with open(args.config, 'wt') as out:
            out.write(''.join(lines))

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
