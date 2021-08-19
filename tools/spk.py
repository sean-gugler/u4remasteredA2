#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate HGR page from Ultima IV "SPK" file (new game)
by Sean Gugler

The bytes are stored bottom-to-top, left-to-right,
compressed with the "SUPER PACKER" method by Steven Meuse.
"""

import sys
import argparse
from itertools import islice,chain
flatten = chain.from_iterable

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('input', help="input, SPK.PRG image file")
    p.add_argument('output', help="output, PRG file in HGR format")
    return p.parse_args(argv[1:])

# Byte offsets to scan lines (bitmap rows) in Apple II HGR memory, in vertical order
screen = [i + j + k  for i in range(0, 0x80, 0x28) for j in range(0, 0x400, 0x80) for k in range(0, 0x2000, 0x400)]

# The first two bytes of a SPK stream declare the values it will use for these two opcodes
Repeat, Pattern = None, None

def main(argv):
    args = usage(argv)

    with open(args.input, 'rb') as f:
        src = f.read()

    # Skip 2-byte load address.
    src = iter(src[2:])
    src = decode_file(src)

    # Write data into an initially-empty screen, with proper HGR memory placement.
    data = bytearray(0x2000 - 8)

    for col in reversed(range(40)):
        for row in reversed(range(144)):
            i = screen[row] + col
            data[i] = next(src)

    with open(args.output, 'wb') as out:
        load_addr = b'\x00\x40'  # lo+hi
        out.write(load_addr + data)

    return 0

def decode_file(data):
    global Repeat, Pattern
    Repeat = next(data)
    Pattern = next(data)
    yield from decode_stream(data)

def decode_stream(data):
    for code in data:

        if code == Repeat:
            N = next(data)
            b = next(data)
            yield from (b for i in range(N))

        elif code == Pattern:
            length = next(data)
            N = next(data)

            pat = list(islice(data, length))
            for i in range(N):
                yield from decode_stream(iter(pat))

        else:
            yield code

if __name__ == '__main__':
    sys.exit(main(sys.argv))
