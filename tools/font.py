#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate an HGR page from Ultima IV "htxt" files (font data)
by Sean Gugler

In the source file, top rows of each glyph are stored,
then row 2, and so on through row 8, for all 128 glyphs.
"""

import sys
import argparse
from itertools import islice,chain

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('input', help="PRG file for font data")
    p.add_argument('output', help="output, PRG file in HGR format")
    return p.parse_args(argv[1:])

# Byte offsets to scan lines (bitmap rows) in Apple II HGR memory, in vertical order
screen = [i + j + k  for i in range(0, 0x80, 0x28) for j in range(0, 0x400, 0x80) for k in range(0, 0x2000, 0x400)]

def main(argv):
    args = usage(argv)

    with open(args.input, 'rb') as f:
        src = f.read()

    # Skip 2-byte load address.
    src = iter(src[2:])

    # Write data into an initially-empty screen, with proper HGR memory placement.
    data = bytearray(0x2000 - 8)

    for line in range(8):
        for row in range(4):
            i = screen[row * 8 + line]
            data[i:i+32] = islice(src, 32)

    with open(args.output, 'wb') as out:
        load_addr = b'\x00\x40'  # lo+hi
        out.write(load_addr + data)

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
