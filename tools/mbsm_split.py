#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Split the MBSM driver into two files for easier analysis with Regenerator.
by Sean Gugler
"""

import sys
import argparse
import os.path

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument('-v', '--verbose', action="store_true", help="Verbose output.")
    p.add_argument('input', help="MBSM.prg file")
    return p.parse_args(argv[1:])

def main(argv):
    args = usage(argv)

    # Read binary program
    with open(args.input, 'rb') as f:
        mbsm = f.read()

    # Generate file names for splits
    base, ext = os.path.splitext(args.input)

    # Write split files
    with open(base + 'a' + ext, 'wb') as out:
        out.write(b'\x00\x04' + mbsm[2:0x0402])
    with open(base + 'b' + ext, 'wb') as out:
        out.write(b'\x00\xFD' + mbsm[0x0402:])

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
