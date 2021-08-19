#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate TLK.BIN compatible with the retail disk image.
by Sean Gugler
"""

import sys
import argparse
import json
import os.path
import itertools 
flatten = itertools.chain.from_iterable

def usage(argv):
    p = argparse.ArgumentParser(description = __doc__.split('\n')[1])  # extract first line of """ header
    p.add_argument("-v", "--verbose", action="store_true",
                   help="Verbose output.")
    p.add_argument("talk_json", help="Input file with all talk data.")
    p.add_argument("output_file", help="Binary file in original sector order.")
    return p.parse_args(argv[1:])

def encode_string(s, lastbit=True):
    bytes = list(ord(c.upper()) for c in s.replace("\n", "\x8d"))
    if lastbit:
        bytes[0:0] = [0]
    return bytes

def bcd(i):
    return int("%d" % i, 16)

def encode_trigger(t):
    return {
        None: 0,
        "job": 3,
        "health": 4,
        "keyword 1": 5,
        "keyword 2": 6,
        "mistake": 10,  #preserve bad retail data byte for one character
    }[t]

CONV_KEYS = [
    "name",
    "pronoun",
    "description",
    "job",
    "health",
    "keyword_response_1",
    "keyword_response_2",
    "question",
    "question_yes_answer",
    "question_no_answer",
]

def encode_conv(conv):
    strings = list(flatten(encode_string(conv[key], lastbit=True) for key in CONV_KEYS))
    kMax = 0xf0
    assert(len(strings) < kMax)
    strings = (strings + [0] * kMax)[:kMax]
    kw1 = encode_string((conv["keyword_1"] + "      ")[:6], lastbit=False)
    kw2 = encode_string((conv["keyword_2"] + "      ")[:6], lastbit=False)
    trigger = encode_trigger(conv["question_trigger"])
    special = 0  # unused retail flag, stub code in game prints "SPECIAL!"
    humility = 1 if conv["humility_question"] else 0
    turnsaway = bcd(conv["turns_away_prob"])
    
    bytelist = strings + kw1 + kw2 + [trigger, special, humility, turnsaway]
    return bytes(bytelist)

def main(argv):
    args = usage(argv)
    
    with open(args.talk_json, "rt", encoding="utf-8") as f:
        talk = json.load(f)
    
    with open(args.output_file, "wb") as f:
        for conv in talk:
            f.write(encode_conv(conv))
    
    return 0
    

if __name__ == '__main__':
    sys.exit(main(sys.argv))
    
