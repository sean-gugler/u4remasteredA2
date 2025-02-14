#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate HGR pages from Ultima IV "CRDS" file
by Sean Gugler

Two pages must be generated, as the cards are too tall
(112 rows) to all fit on one screen (192 rows).

The image bytes are stored uncompressed in the
CRDS file consecutively, row by row then card after card.
"""

import sys
import argparse
import pathlib
from itertools import islice,chain
flatten = chain.from_iterable

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('input', help="input, PRG file for CRDS")
    p.add_argument('output', help="output folder for PRG files in HGR format")
    return p.parse_args(argv[1:])

# Byte offsets to scan lines (bitmap rows) in Apple II HGR memory, in vertical order
screen = [i + j + k  for i in range(0, 0x80, 0x28) for j in range(0, 0x400, 0x80) for k in range(0, 0x2000, 0x400)]

def main(argv):
    args = usage(argv)
    output = pathlib.Path(args.output)

    with open(args.input, 'rb') as f:
        src = f.read()

    # Skip 2-byte load address.
    src = iter(src[2:])

    # Write into an initially-empty screen, with proper HGR memory placement.
    image = [bytearray(0x2000 - 8), bytearray(0x2000 - 8)]

    for card in range(8):
        X,Y = card % 4, card // 4
        for row in range(14 * 8):
            for col in range(10):
                i = screen[row] + X * 10 + col
                image[Y][i] = next(src)

    for i,data in enumerate(image):
        with open(output / f'CARDS{i}.prg', 'wb') as out:
            load_addr = b'\x00\x40'  # lo+hi
            out.write(load_addr + data)

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
