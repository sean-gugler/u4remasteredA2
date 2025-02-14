#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate HGR pages from Ultima IV "cstring" file (end game)
by Sean Gugler

The first part of the file is the uncompressed axiom revelation.
These image bytes are stored in alternating columns,
left then right, moving outward to accommodate the "opening door"
animation. Each column is stored bottom to top.

Following that are SPK-compressed portions. The first 11
combine to form one image, the other 2 are stand-alone.
"""

import sys
import argparse
import pathlib
from itertools import islice,chain
flatten = chain.from_iterable

import spk

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('input', help="input, PRG file for end game")
    p.add_argument('output', help="output folder for PRG files in HGR format")
    return p.parse_args(argv[1:])

# Byte offsets to scan lines (bitmap rows) in Apple II HGR memory, in vertical order
screen = [i + j + k  for i in range(0, 0x80, 0x28) for j in range(0, 0x400, 0x80) for k in range(0, 0x2000, 0x400)]

SCREEN_BYTES = 0x2000 - 8

def main(argv):
    args = usage(argv)
    output = pathlib.Path(args.output)

    with open(args.input, 'rb') as f:
        src = f.read()

    # Skip 2-byte load address.
    src = iter(src[2:])

    # Write data into an initially-empty screen, with proper HGR memory placement.
    data = bytearray(SCREEN_BYTES)

    LEFT = reversed(range(1, 12))
    RIGHT = range(12, 23)
    ROWS = tuple(reversed(range(8 * 1, 8 * 23)))
    for LR in zip(LEFT, RIGHT):
        for row in ROWS:
            for col in LR:
                i = screen[row] + col
                data[i] = next(src)

    with open(output / 'END_AXIOM.prg', 'wb') as out:
        load_addr = b'\x00\x40'  # lo+hi
        out.write(load_addr + data)

    skip = list(islice(src, 22))

    # Now write SPK-compressed slides
    data = bytearray(SCREEN_BYTES)
    for layer in range(11):
        decode_spk(src, data, output / f'END_QUIZ_{layer:02}.prg')
    decode_spk(src, bytearray(SCREEN_BYTES), output / 'END_WIN.prg')
    decode_spk(src, bytearray(SCREEN_BYTES), output / 'END_KEY.prg')

    return 0


def decode_spk(src, overlay, filename):
    decode = spk.decode_file(src)
    for col in reversed(range(1, 23)):
        for row in reversed(range(8, 184)):
            i = screen[row] + col
            overlay[i] |= next(decode)

    with open(filename, 'wb') as out:
        load_addr = b'\x00\x40'  # lo+hi
        out.write(load_addr + overlay)


if __name__ == '__main__':
    sys.exit(main(sys.argv))
