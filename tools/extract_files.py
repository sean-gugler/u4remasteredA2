#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
Extract program and data files from Ultima IV disk images for Apple II
by Sean Gugler
"""

import os
import sys
import argparse
import dos33

def track_sectors(t, s):
    return 256 * (16 * t + s)

disks = (
    ('DOS', track_sectors( 2, 5), 'program'),
    ('MAP', track_sectors(16, 0), 'britannia'),
    ('TLK', track_sectors(16, 0), 'towne'),
    ('DNG', track_sectors(11, 0), 'underworld'),
)

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument("disk_images", nargs=4, metavar='DISK',
        help=f"These must be, in order: {', '.join(f for n,s,f in disks)}")
    p.add_argument("output_dir")
    args = p.parse_args(argv[1:])

    return args

def main(argv):
    args = usage(argv)
    for image, (name, size, folder) in zip(args.disk_images, disks):
        outpath = os.path.join(args.output_dir, folder)
        os.makedirs(outpath, exist_ok=True)
        attr_file = outpath + '.attr'

        dos33.read_files(image, outpath, attr_file)
        remove_unprintable(outpath)
        write_sectors(image, outpath, name, size)

    return 0

def remove_unprintable(folder):
    for root, dirs, files in os.walk(folder):
        for f in files:
            if '%81' in f:
                g = f.replace('%81', '')
                src = os.path.join(root, f)
                dst = os.path.join(root, g)
                os.rename(src, dst)

def write_sectors(inpath, outpath, name, size):
    outfile = os.path.join(outpath, f'{name}.bin')
    with open(inpath, "rb") as f:
        sectors = f.read(size)
    with open(outfile, "wb") as f:
        f.write(sectors)
    

if __name__ == '__main__':
    sys.exit(main(sys.argv))
