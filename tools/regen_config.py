#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
Create a Config script for Regenerator from a binary program file.
by Sean Gugler
"""

import sys
import argparse
import os
import re
from itertools import chain, takewhile
from tass_to_c65 import charmap
import binascii

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument('-v', '--verbose', action="store_true", help="Verbose output.")
    p.add_argument('input', help="Binary program (.prg)")
    p.add_argument('outpath', help="Folder where Regenerator's Config files are located")
    p.add_argument('--addr', help="Force load address, ignoring value in program header")
    p.add_argument('--labels', help="File of external labels")
    return p.parse_args(argv[1:])

def inline_strings(code, addr_start):
    """Bytes after one of these JSR instructions are consumed as zero-terminated strings"""
    JSR = (
        re.compile(rb'\x20\x1b\x08(.*?\x00)'), # jsr_primm_cout
        re.compile(rb'\x20\x1e\x08(.*?\x00)'), # jsr_primm_xy
        re.compile(rb'\x20\x21\x08(.*?\x00)'), # jsr_primm
    )

    Text = {int(k[1:], 16) : ord(v)  for k,v in charmap().items()}

    for m in chain(*[pat.finditer(code) for pat in JSR]):
        s = addr_start + m.start(1)
        e = addr_start + m.end(1)
        span = f'{s:04X}-{e:04X}'
        string = f'{s-3:04X} ' + str(bytes(Text.get(c,c) for c in m.group(1)))
        yield span, string

def main(argv):
    args = usage(argv)

    # Read PRG bytes
    with open(args.input, 'rb') as f:
        data = f.read()

    # Read pre-populated address labels
    if args.labels:
        with open(args.labels, 'rt') as f:
            labels = f.readlines()
    else:
        labels = ''

    # Read the "load address" header from PRG data
    offset = 0
    addr_start = 0x100 * data[1] + data[0]
    if not args.addr is None:
        start = int(args.addr, 16)
        addr_start, offset = start, start - addr_start
    addr_end = addr_start + len(data) - 2

    # Scan PRG for inline strings
    ss = tuple(zip(*inline_strings(data, addr_start - 2)))
    spans, strings = ss or ([], [])

    # Figure out the file name that Regenerator will use for this PRG,
    # which includes an embedded CRC of its data bytes
    crc = binascii.crc32(data)
    outfile = os.path.join(args.outpath, os.path.basename(args.input) + '.' + str(crc))

    # Write the Config script file
    with open(outfile, 'wt') as out:
        print(f':CODE START\n{addr_start:04X}', file=out)
        print(f':CODE END\n{addr_end:04X}', file=out)
        print(':DATA BYTES\n' + '\n'.join(spans), file=out)
        print(':SIDE COMMENTS\n' + '\n'.join(strings), file=out)
        print(':USER LABELS\n' + ''.join(labels), file=out)
        print(f':LOAD OFFSET\n{offset:04X}', file=out)
        print(':SYSTEM\nApple II', file=out)

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
