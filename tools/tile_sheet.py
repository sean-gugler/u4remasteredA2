#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate two HGR pages from Ultima IV "shape" files (tile sheet)
by Sean Gugler

Each tile is a 2x2 area of character cells, or 14x16 pixels.
All left halves, intended for odd-numbered cell columns, are in shape0 file.
All right halves, intended for even-numbered cell columns, are in shape1 file.

The odd/even parity is imposed by Apple II HGR characteristics, whereby
color is determined by 8th bit and whether pixel column is odd/even.
Since each byte only holds 7 pixels, byte columns also alternate parity.

Two pages must be generated for first and second halves because
full tile sheet is 240x256 and won't fit on 280x192 screen.
"""

import sys
import argparse
from itertools import islice,chain

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('shape0', help="input, PRG file for shape table 0")
    p.add_argument('shape1', help="input, PRG file for shape table 1")
    p.add_argument('tile0', help="output, PRG file for top half of tile sheet")
    p.add_argument('tile1', help="output, PRG file for bottom half of tile sheet")
    return p.parse_args(argv[1:])

# Byte offsets to scan lines (bitmap rows) in Apple II HGR memory, in vertical order
screen = [i + j + k  for i in range(0, 0x80, 0x28) for j in range(0, 0x400, 0x80) for k in range(0, 0x2000, 0x400)]

def main(argv):
    args = usage(argv)

    with open(args.shape0, 'rb') as f:
        shape0 = f.read()
    with open(args.shape1, 'rb') as f:
        shape1 = f.read()

    # Skip 2-byte load address.
    odd = sort_vertically(shape0[2:])
    even = sort_vertically(shape1[2:])
    lines = (chain(*zip(a,b)) for a,b in zip(odd,even))

    for name in (args.tile0, args.tile1):
        half = islice(lines, 128)

        # Write each shape line into an initially-empty screen, with proper HGR memory placement.
        data = bytearray(0x2000 - 8)
        for i,line in zip(screen,half):
            # enumeration begins with odd column for correct colors.
            for j,byte in enumerate(line,1):
                data[i+j] = byte
        with open(name, 'wb') as out:
            load_addr = b'\x00\x40'  # lo+hi
            out.write(load_addr + data)

    return 0

def sort_vertically(data):
    """Shape data stores all top rows, then all second rows, etc"""
    it = iter(data)
    pieces = [[list(islice(it, 16)) for shelf in range(16)] for line in range(16)]
    return chain(*zip(*pieces))


if __name__ == '__main__':
    sys.exit(main(sys.argv))
