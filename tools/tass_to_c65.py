#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Convert assembly source from TASS format to CC65 format.
by Sean Gugler

Regenerator outputs TASS format assembly source.
It's straight-forward to convert this to a format CC65 can use,
but I've added some commenting conventions to support symbolic
literal values and multiple symbols per address.
"""

import sys
import argparse
import os.path
import itertools
import re
import string

org    = re.compile(r'\t\* = (.*)')
char   = re.compile(r'\t.charmap \$(..), (\$..)$')
define = re.compile(r'([^ \t].*) = (.*)')
data   = re.compile(r'.BYTE ([^;]*)\n')
branch = re.compile(r'([BJ]..) ([+-].*)')
literal = re.compile(r'(.*)(\$.*);#([^;]+)(;.*)?')
zp = re.compile(r'([^ ]*)(.*);\$(\w+_\w+)(\s*;.*)?')
oper = re.compile(r'([^ ]* *)([^;]*)?(;[^;]+)?(;.*)?')

def hex8(char):
    int8 = ord(char) | 0x80
    str8 = f'${int8:02x}'
    return str8

def charmap():
    trans = {hex8(c): c  for c in string.printable}
    #Bad idea. Makes more readable source, but breaks
    #even/odd color parity for these custom glyphs.
    # trans['$1c'] = '<'
    # trans['$1d'] = '<'
    # trans['$1e'] = '>'
    # trans['$1f'] = '>'
    trans['$84'] = chr(4)
    trans['$8d'] = '\r'
    trans['$ff'] = '\n'
    del trans['$a2']  # double-quote " confuses compiler
    return trans

def main(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of ''' header
    p.add_argument("-v", "--verbose", action="store_true",
                   help="Verbose output.")
    p.add_argument("-c", "--case", action="store_true",
                   help="Convert strings to upper-case.")
    p.add_argument("-s", "--strings", action="store_true",
                   help="Generate string comments.")
    p.add_argument("input", help="TASS file, as saved by Regenerator")
    p.add_argument("outsrc", help="Where to generate .s file")
    p.add_argument("outinc", help="Where to generate .i file")
    args = p.parse_args(argv[1:])

    Text = charmap()
    Syms = {}
    Values = []

    with open(args.input, "rt") as f:
        lines = f.readlines()
    
    with open(args.outsrc, "wt") as f:
        # Write header
        inc = os.path.basename(args.outinc)
        f.write('\t.include "uscii.i"\n')
        f.write(f'\t.include "{inc}"\n\n')

        # Emit .byte statements in chunks of 8
        bytelist = []
        def flush_bytes():
            it = iter(bytelist)
            while b := list(itertools.islice(it,8)):
                s = ','.join(b)
                f.write(f'\t.byte {s}\n')
            bytelist[:] = []

        st_count = None

        for line in lines:

            # Full line comment
            if line[0] == ';':
                out = line

            # Start address
            elif m := org.match(line):
                seg = 'OVERLAY' if m.group(1) == '$8800' else 'MAIN'
                out = f'\n\n\t.segment "{seg}"'

            # Symbol Definitions
            elif m := define.match(line):
                name, value = m.groups()
                #out = line.lower()
                out = f'{name} = {value.lower()}'
                if name in Syms:
                    assert(Syms[name] == value)
                    out = ';' + out
                elif any(c in name for c in ' +-'):
                    out = ';' + out
                Syms[name] = value

            # Instruction, with optional label
            elif '\t' in line:
                label, code = line.split('\t')
                out = '\t'

                # Forward label
                if code.startswith('='):
                    if not '+' in label:
                        flush_bytes()
                        #f.write(label.lower().strip() + code)
                        f.write(label.strip() + code)
                    continue

                # Write label on separate line, but
                # skip derivative labels like "symbol + 1"
                if label and not '+' in label[1:]:
                    if label in ('+','-'):
                        out = ':' + out
                    else:
                        flush_bytes()
                        #label = label.lower().strip()
                        label = label.strip()
                        f.write(f'{label}:\n')
                        st_count = 0 if label == 'string_table' else None

                # JSR j_primm  ;b'left\n\x00'
                # .BYTE $EC,$E5,$E6,$F4,$8D,$00

                # Accumulate .byte statements, detecting $00
                # as potential marker at end of a text string
                if m := data.match(code):
                    bytelist.extend(m.group(1).lower().split(','))
                    try:
                        while (i := bytelist.index('$00')) >= 0:
                            st = ''.join(Text[b] for b in bytelist[:i])
                            if args.case:
                                st = st.upper()
                            st = st.replace('\n', '", $ff\n\t.byte "')
                            st = st.replace('\r', '", $8d\n\t.byte "')
                            st = f'\t.byte "{st}", 0\n'
                            st = st.replace('"\x04', '$84,"')
                            nulstring = '"", '
                            st = st.replace(nulstring, '')
                            if st_count is not None:
                                f.write(f'; STRING ${st_count:02X} ({st_count})\n')
                                st_count += 1
                            f.write(st)
                            bytelist = bytelist[i+1:]
                    except (KeyError):
                        # print('KeyError', len(bytelist))
                        pass
                    except (ValueError):
                        # print('ValueError', len(bytelist))
                        pass
                    continue

                # Branch with convenience label '+' or '-'
                elif m := branch.match(code):
                    op, label = m.groups()
                    out += f'{op.lower()} :{label}\n'

                elif m := oper.match(code):
                    op, value, expr, comment = m.groups('')
                    if '$' in value:
                        value = value.lower()
                    if expr.startswith(';#'):
                        expr = expr[2:]
                        if expr == '-\n':
                            comment = ''
                        elif expr.startswith(' '):
                            comment = ';' + expr[1:] + comment
                        else:
                            Values.append((value[1:].strip(), expr.strip()))
                            value = '#' + expr
                    elif expr.startswith(';$'):
                        Values.append((value.strip(), expr.strip()))
                        value = expr[2:]
                    elif (expr.startswith(";b'") or
                          expr.startswith(';b"') ) and not args.strings:
                        comment = ''
                    else:
                        comment = expr + comment
                    value = value.replace( ',X' , ',x' )
                    value = value.replace( ',Y' , ',y' )

                    out += f'{op.lower()}{value}{comment}'
                else:
                    raise Exception
                """
                # Replace literal values with symbols
                elif m := literal.match(code):
                    op, value, expr, comment = m.groups()
                    op, value = (x.lower() for x in (op, value))
                    if expr == '-\n':
                # LDA #$CC     ;#-
                        out += f'{op}{value}'
                    elif expr.startswith(' '):
                # AND #$07     ;# modulo
                        out += f'{op}{value};{expr[1:]}'
                    else:
                # LDX #$7F     ;#file_id_smap ;saved_map
                # .BYTE $B0    ;#arena_dng_hall ; orb
                # LDA #$CF     ;#music_Overworld
                # LDX #$20     ;#object_max + 1
                        out += f'{op}{expr}{comment or ""}'
                        Values.append((value.strip(), expr.strip()))

                # Allow multiple symbols for same address
                elif m := zp.match(code):
                # LDA zp6A     ;$zp_field_type
                    op, value, expr, comment = m.groups()
                    out += f'{op.lower()} {expr}{comment or ""}'
                    Values.append((value.strip(), expr.strip()))

                elif ';' in code:
                # CMP #$18     ;row 24
                # BEQ @check_transport ;loc_world
                    asm, comment = code.split(';', 1)
                    if comment.startswith('#'):
                        comment = comment[1:]
                    comment = ';' + comment.strip()
                    out += asm.lower() + comment


                # All other statements verbatim
                else:
                    out += code.lower()
                """
            else:
                out = line

            flush_bytes()
            f.write(out.rstrip() + '\n')

        flush_bytes()

    with open(args.outinc, "wt") as f:
        # Write definitions
        def rekey(item):
            value,symbol = item
            if '_' in symbol:
                prefix,suffix = symbol.split('_', 1)
                suffix = '_' + suffix
            else:
                prefix,suffix = '', symbol
            return (prefix,value,suffix)

        def unique(it):
            prev = None
            for cur in it:
                if cur != prev:
                    yield cur
                prev = cur

        prev = None
        for item in unique(sorted(map(rekey, Values))):
            prefix,value,suffix = item
            if prefix != prev:
                print('', file=f)
            prev = prefix

            if value.startswith('zp'):
                value = '$' + value[2:4].lower()
            symbol = prefix + suffix
            comment = ';' if any(c in symbol for c in ' +-<>') else ''
            print(f'{comment}{symbol} = {value}', file=f)

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
