#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import sys
import argparse
import re


class PatcherError(Exception):
    pass

class Patcher(object):
    """Perform in-memory binary patching."""
    
    def __init__(self, source_path):
        super(Patcher, self).__init__()
        with open(source_path, "rb") as f:
            self.data = list(f.read())
        self.offset = 0
        self.match_len = 0
    
    def patch(self, patch_path):
        """Read and execute patch commands from file."""
        
        with open(patch_path, "rt", encoding="utf-8") as f:
            for i, line in enumerate(f):
                self.execute(line, i + 1)
    
    re_comment = re.compile(r'\s*#.*$')
    re_command = re.compile(r'\b(?P<command>\w+)\((?P<args>[^)]*)\)')
    
    def parse_args(self, args):
        argvalues = list()
        in_quotes = False
        hex_value = None
        for char in args:
            if char == u'"':
                if in_quotes:
                    argvalues.extend(ord(x) | 0x80 for x in quoted_string)
                else:
                    quoted_string = ""
                in_quotes = not in_quotes
            else:
                if in_quotes:
                    quoted_string += char
                elif char == " ":
                    if hex_value is not None:
                        argvalues.append(hex_value)
                        hex_value = None
                elif ("0" <= char <= "9") or ("a" <= char.lower() <= "f"):
                    if hex_value is None:
                        hex_value = int(char, 16)
                    else:
                        hex_value = hex_value * 16 + int(char, 16)
        if hex_value is not None:
            argvalues.append(hex_value)
        return argvalues
    
    def execute(self, line, linenum):
        line = self.re_comment.sub("", line).lstrip().rstrip()
        if not line:
            return
        try:
            for command in self.re_command.finditer(line):
                cmd = command.group("command")
                try:
                    args = self.parse_args(command.group("args"))
                except ValueError as e:
                    raise PatcherError("Syntax error")
                if cmd == "offset":
                    self.cmd_offset(args)
                elif cmd == "match":
                    self.cmd_match(args)
                elif cmd == "replace":
                    self.cmd_replace(args)
                elif cmd == "truncate":
                    self.cmd_truncate(args)
                elif cmd == "insert":
                    self.cmd_insert(args)
                elif cmd == "append":
                    self.cmd_append(args)
                elif cmd == "delete":
                    self.cmd_delete(args)
                else:
                    raise PatcherError("Unknown command '%s'" % cmd)
        except PatcherError as e:
            raise PatcherError("Line %d: %s" % (linenum, e))
    
    def cmd_offset(self, args):
        if len(args) != 1:
            raise PatcherError("Offset expected value")
        self.offset = args[0]
        if self.offset < 0 or self.offset > len(self.data):
            raise PatcherError("Offset out of range")
    
    def cmd_match(self, args):
        self.match_len = 0
        if len(args) < 1:
            raise PatcherError("Match expected values")
        try:
            for i, byte in enumerate(args):
                if self.data[self.offset + i] != byte:
                    raise PatcherError("Match failed at offset %04x" % (self.offset + i))
        except IndexError:
            raise PatcherError("Match out of range")
        self.match_len = len(args)
    
    def cmd_replace(self, args):
        if len(args) != self.match_len:
            raise PatcherError("Replace expected %d matched bytes" % len(args))
        try:
            for i, byte in enumerate(args):
                self.data[self.offset + i] = byte
        except IndexError:
            raise PatcherError("Replace out of range")
    
    def cmd_truncate(self, args):
        if len(args) != 1:
            raise PatcherError("Truncate expected value")
        self.offset = args[0]
        if self.offset > len(self.data):
            raise PatcherError("Truncate out of range")
        del self.data[self.offset:]
    
    def cmd_insert(self, args):
        if len(args) < 1:
            raise PatcherError("Insert expected values")
        self.data[self.offset:self.offset] = args
    
    def cmd_append(self, args):
        if len(args) < 1:
            raise PatcherError("Append expected values")
        self.data.extend(args)
    
    def cmd_delete(self, args):
        self.match_len = 0
        if len(args) < 1:
            raise PatcherError("Delete expected values")
        try:
            for i, byte in enumerate(args):
                if self.data[self.offset + i] != byte:
                    raise PatcherError("Delete failed match at offset %04x" % (self.offset + i))
        except IndexError:
            raise PatcherError("Delete out of range")
        del self.data[self.offset:self.offset + len(args)]
    
    def save(self, target_path):
        """Saved patched file."""
        
        with open(target_path, "wb") as f:
            f.write(bytes(self.data))


def main(argv):
    p = argparse.ArgumentParser()
    p.add_argument("-v", "--verbose", action="store_true",
                   help="Verbose output.")
    p.add_argument("source")
    p.add_argument("patch")
    p.add_argument("target")
    args = p.parse_args(argv[1:])
    
    try:
        patcher = Patcher(args.source)
        patcher.patch(args.patch)
        patcher.save(args.target)
    except PatcherError as e:
        print(e, file=sys.stderr)
        return 1
    
    return 0
    

if __name__ == '__main__':
    sys.exit(main(sys.argv))
    
