#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Manipulate contents of an Apple II disk image formatted for DOS 3.3
by Sean Gugler

File names in host system use munging conventions inspired by CiderPress.
Portions borrowed from https://github.com/jtauber/a2disk/
"""

import os.path
import sys
import argparse
import re
import math
from itertools import chain, islice, zip_longest
flatten = chain.from_iterable

verbose = False

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument('-v', '--verbose', action='store_true', help="Verbose output.")
    p.add_argument('disk_image', help="Existing Apple DOS 3.3 formatted disk image")
    p.add_argument('-d', '--host_dir', default=".", help="Folder on host to copy files to or from. Default is current folder.")
    p.add_argument('--attr', help="File for attributes table, like lock status and file type.")
    p.add_argument('--track', type=int, help="Track to begin raw sector write")
    p.add_argument('--sector', type=int, help="Sector to begin raw sector write")

    group = p.add_mutually_exclusive_group()
    group.add_argument('-c', '--catalog', action='store_true', help="Display contents of disk")
    group.add_argument('-r', '--read', action='store_true', help="Copy named files to host, or all files if none are specified")
    group.add_argument('-w', '--write', action='store_true', help="Copy named files from host, all files if folder is specified")
    # todo: --write_strategy
    group.add_argument('-s', '--sector-write', action='store_true', help="Write raw sector data without catalog entries")
    group.add_argument('-f', '--format', action='store_true', help="Format disk, wiping table of contents")

    p.add_argument('files', nargs='*', help="Optional list of files")

    return p.parse_args(argv[1:])

def main(argv):
    args = usage(argv)

    global verbose
    verbose = args.verbose

    if args.catalog:
        catalog(args.disk_image)
    elif args.read:
        read_files(args.disk_image, args.host_dir, args.attr, *args.files)
    elif args.write:
        write_files(args.disk_image, args.host_dir, args.attr, *args.files)
    elif args.sector_write:
        write_sectors(args.disk_image, args.track, args.sector, *args.files)
    elif args.format:
        format(args.disk_image)
    return 0

# https://stackoverflow.com/a/65092767/2856574
class Bitfield:
    def __init__(self, bits):
        self.bytes = bytearray(math.ceil(bits / 8))  if type(bits) == int  else bits

    def __getitem__(self, idx):
        return self.bytes[idx // 8] >> (idx % 8) & 1

    def __setitem__(self, idx, value):
        mask = 1 << (idx % 8)
        if value:
            self.bytes[idx // 8] |= mask
        else:
            self.bytes[idx // 8] &= ~mask

def read_word_littleendian(buff, offset):
    return buff[offset] + buff[offset + 1] * 0x100

def write_word_littleendian(word):
    return bytes((word % 0x100, word // 0x100))

reMunged = re.compile(r'%(..)')

def encode_char(b):
    c = chr(b & 0x7F)
    return c if c.isprintable() and c != '%' else f'%{b:02x}'

def decode_str(s):
    s = reMunged.sub(lambda match: int(m.group(1), 16),  s)
    return bytes(ord(c) | 0x80  for c in s)


class Disk:
    """Disk image, managed at a sector level.

    APIs to read and write sector data in memory image.
    APIs to read and write entire image to host file system.
    """

    TRACKS_PER_DISK = 0x23
    SECTORS_PER_TRACK = 0x10
    SECTOR_SIZE = 0x100
    
    Length = SECTOR_SIZE * SECTORS_PER_TRACK * TRACKS_PER_DISK

    def __init__(self, image_name=None):
        if image_name:
            self.read_image(image_name)
        else:
            self.create()

    def create(self):
        self.disk_image = bytearray(Disk.Length)

    def read_image(self, image_name):
        self.image_name = image_name
        with open(self.image_name, "rb") as f:
            self.disk_image = bytearray(f.read())
        if len(self.disk_image) != Disk.Length:
            raise Exception("Wrong size, not a standard Apple DOS 3.3 disk")

    def write_image(self, image_name):
        self.image_name = image_name
        with open(self.image_name, "wb") as f:
            f.write(self.disk_image)

    def image_indices(self, track, sector, length):
        start = (track * Disk.SECTORS_PER_TRACK + sector) * Disk.SECTOR_SIZE
        end = start + length
        if verbose: print(f'Seek T:{track:02X} S:{sector:X} L:{length} = start {start} end {end}')
        if not (0 <= start <= Disk.Length and 0 <= end <= Disk.Length):
            raise Exception("seek out of range")
        return start,end

    def read_sector(self, track, sector):
        start,end = self.image_indices(track, sector, Disk.SECTOR_SIZE)
        return self.disk_image[start:end]

    def write_sector(self, track, sector, data):
        start,end = self.image_indices(track, sector, len(data))
        self.disk_image[start:end] = data

class VTOC:
    """Apple ][ DOS 3.3 Volume Table of Contents."""

    # location of VTOC
    TRACK = 0x11
    SECTOR = 0x00

    # useful offsets into VTOC
    CATALOG_TRACK_OFFSET = 0x01
    CATALOG_SECTOR_OFFSET = 0x02
    VOLUME_NUMBER_OFFSET = 0x06
    LAST_TRACK_ALLOC_OFFSET = 0x30
    ALLOC_DIRECTION_OFFSET = 0X31
    TRACK_MAP_OFFSET = 0x38

    TRACK_MAP_SIZE = 0x04

    # offset, value pairs for validating DOS 3.3 VTOC
    VALIDATION = {
        0x03: 0x03,  # DOS version number
        0x27: 0x7A,  # max number of track/sector pairs
        0x34: Disk.TRACKS_PER_DISK,  # tracks per disk
        0x35: Disk.SECTORS_PER_TRACK,  # sectors per track
        0x36: Disk.SECTOR_SIZE % 0x100,  # bytes per sector (low)
        0x37: Disk.SECTOR_SIZE // 0x100,  # bytes per sector (high)
    }

    # offset, value pairs for formatting a fresh DOS 3.3 VTOC
    FRESH = {**VALIDATION,
        0x00: 0x04,  # standard signature
        CATALOG_TRACK_OFFSET: TRACK,
        CATALOG_SECTOR_OFFSET: Disk.SECTORS_PER_TRACK - 1,
        VOLUME_NUMBER_OFFSET: 0xFE,
        LAST_TRACK_ALLOC_OFFSET: TRACK,
        ALLOC_DIRECTION_OFFSET: 0x01,
    }

    def __init__(self, disk=None):
        if disk:
            self.read(disk)
        else:
            self.format()

    def validate(self):
        for offset, value in VTOC.VALIDATION.items():
            if self.data[offset] != value:
                raise Exception("not an Apple DOS 3.3 disk")

    def format(self):
        self.data = bytearray(VTOC.FRESH.get(i, 0)  for i in range(Disk.SECTOR_SIZE))
        self.free = [Bitfield(32) for i in range(Disk.TRACKS_PER_DISK)]

        for track in range(Disk.TRACKS_PER_DISK):
            for sector in range(Disk.SECTORS_PER_TRACK):
                self.mark(track, sector, True)
        self.mark(VTOC.TRACK, VTOC.SECTOR, False)

    def read(self, disk):
        self.disk = disk
        self.data = bytearray(disk.read_sector(VTOC.TRACK, VTOC.SECTOR))
        self.validate()

        tmap = iter(self.data[VTOC.TRACK_MAP_OFFSET:])
        next_bits = lambda it: Bitfield(bytearray(islice(it, VTOC.TRACK_MAP_SIZE)))
        self.free = [next_bits(tmap) for i in range(Disk.TRACKS_PER_DISK)]

    def write(self, disk):
        self.disk = disk
        # update the BAM from free list
        start = VTOC.TRACK_MAP_OFFSET
        end = start + VTOC.TRACK_MAP_SIZE * Disk.TRACKS_PER_DISK
        self.data[start:end] = b''.join(field.bytes for field in self.free)
        disk.write_sector(VTOC.TRACK, VTOC.SECTOR, self.data)

    def is_marked(self, track, sector):
        return self.free[track][sector ^ 8]

    def mark(self, track, sector, free):
        self.free[track][sector ^ 8] = free

    def alloc_strategy(self):
        for track in reversed(range(Disk.TRACKS_PER_DISK)):
            for sector in reversed(range(Disk.SECTORS_PER_TRACK)):
                if self.is_marked(track, sector):
                    self.mark(track, sector, False)
                    yield track, sector

    def alloc(self, count):
        yield from islice(self.alloc_strategy(), count)

    @property
    def disk_volume(self):
        return self.data[VTOC.VOLUME_NUMBER_OFFSET]

    @property
    def free_sectors(self):
        return sum(flatten(self.free))

    @property
    def catalog_track_sector(self):
        return self.data[VTOC.CATALOG_TRACK_OFFSET], self.data[VTOC.CATALOG_SECTOR_OFFSET]


class SectorChain:
    """Follow a chain of sectors"""

    PAYLOAD_SIZE = Disk.SECTOR_SIZE - 3

    MAX_HOPS = Disk.SECTORS_PER_TRACK * Disk.TRACKS_PER_DISK  # to prevent infinite loop caused by corrupt disk

    def __init__(self, disk):
        self.disk = disk

    def read(self, track, sector):
        """Yield sectors given a starting track/sector."""
        for hop in range(SectorChain.MAX_HOPS):
            if verbose: print(f'chain T:{track:02X} S:{sector:X}')
            if track == 0x00:
                return
            data = self.disk.read_sector(track, sector)
            if 0 != data[0]:
                raise Exception(f"unexpected header byte in track/sector chain T:{track:02X} S:{sector:X}")
            yield data[3:], (track,sector)
            track  = data[1]
            sector = data[2]
        raise Exception("exceeded track/sector list hops")

    def write(self, where, what):
        links = where[1:] + [(0,0)]
        for (tLink, sLink), (tWrite, sWrite), data in zip(links,where,what):
            payload = bytes([0, tLink, sLink]) + data
            if verbose: print(f'chain T:{tWrite:02X} S:{sWrite:X}')
            self.disk.write_sector(tWrite, sWrite, payload)

class CatalogEntry:
    """
    represent a single file entry in the disk catalog

    Members are:
     track - start track of track/sector list for file
     sector - start sector of track/sector list for file
     locked - whether file is locked or not
     file_type - type of file (see Catalog.FILE_TYPES)
     blocks - size of file, measured in sectors
     name - name of file (padded to 30 characters)
    """
    def read(self, buff):
        self.track     = buff[0x00]
        self.sector    = buff[0x01]
        self.locked    = buff[0x02] & 0x80
        self.file_type = buff[0x02] & 0x7F
        self.name = ''.join(map(encode_char, buff[0x03:0x21]))
        self.blocks = read_word_littleendian(buff, 0x21)
        self.valid = self.track not in (0x00, 0xFF) and buff[0x03] != 0
        if verbose: print(f'CatalogEntry valid {self.valid} T {self.track} buf3 {buff[0x03]}')
        return self
    
    def write(self):
        lock_and_type = self.file_type | (0x80 if self.locked else 0x00)
        name = (decode_str(self.name) + b'\xA0' * 30)[:30]

        data = bytes([self.track, self.sector, lock_and_type]) + name + write_word_littleendian(self.blocks)
        assert(len(data) == Catalog.ENTRY_SIZE)
        return data

class Catalog:
    """Read an Apple ][ DOS 3.3 Disk Catalog."""

    ENTRY_OFFSET = 0x08
    ENTRY_SIZE = 0x23
    EntryStarts = range(ENTRY_OFFSET, SectorChain.PAYLOAD_SIZE, ENTRY_SIZE)

    FILE_TYPES = {0x00: "T", 0x01: "I", 0x02: "A", 0x04: "B", 0x08: "S", 0x10: "R", 0x20: "a", 0x40: "b"}
    FILE_CODES = {v:k for k,v in FILE_TYPES.items()}

    def __init__(self, vtoc):
        self.vtoc = vtoc
        self.disk = vtoc.disk

    def format(self):
        track, sector = self.vtoc.catalog_track_sector
        self.vtoc.mark(track, 1, False)
        while self.vtoc.is_marked(track, sector):
            self.vtoc.mark(track, sector, False)
            self.disk.write_sector(track, sector, bytes([0, track, sector - 1]))
            sector -= 1

    def entries(self):
        """Yield catalog entries"""
        track, sector = self.vtoc.catalog_track_sector
        for page,ts in SectorChain(self.disk).read(track, sector):
            all_entries = (CatalogEntry().read(page[i:]) for i in Catalog.EntryStarts)
            yield from (entry for entry in all_entries if entry.valid)

    def write(self, new_entry):
        track, sector = self.vtoc.catalog_track_sector
        for page,ts in SectorChain(self.disk).read(track, sector):
            for i in Catalog.EntryStarts:
                entry = CatalogEntry().read(page[i:])
                if not entry.valid:
                    page[i:i+Catalog.ENTRY_SIZE] = new_entry.write()
                    # ick, this is clumsy
                    t,s = ts
                    if verbose: print(f'Writing catalog entry {i} T:{t:02X} S:{s:X}')
                    data = self.disk.read_sector(t,s)
                    data[3:] = page[:]
                    self.disk.write_sector(t,s,data)
                    return
                else:
                    if verbose: print(f'Skipping catalog entry {i}')
        raise Exception("No room in catalog")

class File:
    """
    Read or write an Apple ][ DOS 3.3 file.

    Manages track/sector lists for a data stream.
    """

    TRACKLIST_OFFSET = 0x09
    TRACKLIST_COUNT = (SectorChain.PAYLOAD_SIZE - TRACKLIST_OFFSET) // 2

    def __init__(self, vtoc):
        self.vtoc = vtoc
        self.disk = vtoc.disk

    def read(self, track, sector):
        """Yield the sectors of a file given the starting track/sector of its track/sector list."""
        for ts_list,ts in SectorChain(self.disk).read(track, sector):
            for i in range(0x09, 0xFC, 0x02):
                track  = ts_list[i]
                sector = ts_list[i+1]
                if verbose: print(f'read  T:{track:02X} S:{sector:X}')
                if track == 0x00 and sector == 0x00:
                    break
                yield self.disk.read_sector(track, sector)

    def write(self, data):
        # Number of sectors for data
        N = math.ceil(len(data) / Disk.SECTOR_SIZE)
        # Count of sectors used by track/sector list ("ts_list" below)
        C = math.ceil(N / File.TRACKLIST_COUNT)

        TS = list(self.vtoc.alloc(C + N))
        LTS,DTS = TS[:C],TS[C:]
        if verbose: print(f'alloc {len(data)} bytes in {C} TrackList sectors + {N} data sectors')
        if verbose: print(f'+ {C} TrackList sectors: + {N} data sectors')

        it = iter(DTS)
        ts_list = (
            b'\0' * File.TRACKLIST_OFFSET +
            bytes(flatten(islice(it, File.TRACKLIST_COUNT)))
            for i in range(C)
        )
        SectorChain(self.disk).write(LTS, ts_list)

        if verbose: print(f'Writing {len(data)} bytes in {N} blocks')
        it = iter(data)
        for t,s in DTS:
            self.disk.write_sector(t, s, bytes(islice(it, Disk.SECTOR_SIZE)))

        return LTS[0], C+N


class BAM:
    """Visual depiction of the Block Allocation Map for a whole disk"""

    def __init__(self, vtoc):
        self.vtoc = vtoc

    def char(self, track, sector):
        return '.' if self.vtoc.is_marked(track, sector) else '+'
        
    def render(self):
        tracks  = range(Disk.TRACKS_PER_DISK)
        sectors = range(Disk.SECTORS_PER_TRACK)
        for s in sectors:
            yield ''.join(self.char(t,s) for t in tracks)


def catalog(image_name):

    disk = Disk(image_name)
    vtoc = VTOC(disk)
    bam = BAM(vtoc)

    print()
    print("Disk Volume {}, Free Blocks: {}".format(vtoc.disk_volume, vtoc.free_sectors))
    print()

    def format(entry):
        lock = '*' if entry.locked else ' '
        ftype = Catalog.FILE_TYPES[entry.file_type]
        return f" {lock}{ftype} {entry.blocks:03d} {entry.name}"

    entries = map(format, Catalog(vtoc).entries())
    for entry, sector in zip_longest(entries, bam.render(), fillvalue=' '*38):
        print(f"{entry} {sector}")

    print()


def read_files(image_name, output_folder, attr_file=None, *files):
    if verbose: print(f'reading {"all" if not files else len(files)} files from "{image_name}"')

    disk = Disk(image_name)
    vtoc = VTOC(disk)
    cat = Catalog(vtoc).entries()

    attr = []
    for entry in cat:
        host_name = entry.name.rstrip()
        if verbose: print(f'found "{host_name}"')
        if (not files) or host_name in files:
            lock = '*' if entry.locked else ' '
            ftype = Catalog.FILE_TYPES[entry.file_type]
            attr.append(f'{lock}{ftype} {host_name}')

            out = bytearray()

            size = entry.blocks * Disk.SECTOR_SIZE if not ftype in 'BA' else None
            for data in File(vtoc).read(entry.track, entry.sector):
                if size is None:
                    if ftype == 'B':
                        size = read_word_littleendian(data, 2) + 2
                        data = data[:2] + data[4:]
                        host_name += '.prg'
                    else:
                        size = read_word_littleendian(data, 0)
                        data = data[2:]
                        host_name += '.bas'
                if size > 0:
                    out.extend(data[:size])
                size -= len(data)

            path = os.path.join(output_folder, host_name)
            if verbose: print(f'writing "{host_name}" to {output_folder}')
            with open(path, "wb") as f:
                f.write(out)
    if attr_file:
        if verbose: print(f'writing attributes to "{attr_file}"')
        with open(attr_file, "wt") as f:
            f.write('\n'.join(attr))

def write_sectors(image_name, track, sector, raw_file):
    disk = Disk(image_name)
    vtoc = VTOC(disk)

    with open(raw_file, "rb") as f:
        data = f.read()
    disk.write_sector(track, sector, data)

    size = Disk.SECTOR_SIZE
    N = math.ceil(len(data) / size)
    if verbose: print(f'Writing {len(data)} bytes to T:{track:02X} S:{sector:X}')

    for i in range(N):
        if not vtoc.is_marked(track, sector):
            raise Exception(f"Track {track} sector {sector} already in use")
        vtoc.mark(track, sector, False)
        sector += 1
        if sector >= Disk.SECTORS_PER_TRACK:
            sector = 0
            track += 1

    vtoc.write(disk)
    disk.write_image(image_name)

reAttr = re.compile(r'([ *])([baRSBAIT]) (.*)')

def read_attr(attr_file):
    """Read locked status and file type from an attributes file, such as one written by read_files()"""
    attr = {}
    try:
        with open(attr_file, "rt") as f:
            for line in f.readlines():
                lock, ftype, name = reAttr.match(line).groups() 
                attr[name] = (lock == '*', ftype)
    except TypeError:
        if attr_file: print(f'cannot read "{attri_file}"')
    return attr

def write_files(image_name, output_folder, attr_file, *files):
    if verbose: print(f'writing {"all" if not files else len(files)} files to "{image_name}"')

    disk = Disk(image_name)
    vtoc = VTOC(disk)
    cat = Catalog(vtoc)

    attr = read_attr(attr_file)

    output_folder = output_folder or '.'
    for path in enumerate_files(output_folder, files):
        with open(path, "rb") as f:
            data = f.read()
        if path.endswith('.prg'):
            data = data[:2] + write_word_littleendian(len(data) - 2) + data[2:]
            path = path[:-4]
        if path.endswith('.bas'):
            data = write_word_littleendian(len(data)) + data
            path = path[:-4]

        e = CatalogEntry()

        (e.track, e.sector), e.blocks = File(vtoc).write(data)
        e.name = os.path.basename(path)
        e.locked, ftype = attr.get(e.name, (True, 'B'))
        e.file_type = Catalog.FILE_CODES[ftype]

        cat.write(e)

    vtoc.write(disk)
    disk.write_image(image_name)

def enumerate_files(folder, filespec):
    for name in filespec:
        path = os.path.join(folder, name)
        if os.path.isdir(path):
            for root,dirs,files in os.walk(path):
                yield from (os.path.join(root, f) for f in files)
                break
        else:
            yield path

def format(image_name):
    if verbose: print(f'formatting "{image_name}"')

    disk = Disk()
    vtoc = VTOC()
    vtoc.write(disk)

    cat = Catalog(vtoc)
    cat.format()
    vtoc.write(disk)
    disk.write_image(image_name)


if __name__ == '__main__':
    sys.exit(main(sys.argv))
