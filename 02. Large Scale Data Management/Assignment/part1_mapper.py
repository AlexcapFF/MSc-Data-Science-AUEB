#!/usr/bin/env python
import sys
import re

def couples(the_list):
    return zip(the_list,the_list[1:])

# get all lines from STDIN
for line in sys.stdin:
    # remove leading and trailing whitespace, symbol characters and lowercase
    line = line.strip()
    line = re.sub(r"[^a-zA-Z0-9]+", ' ', line).lower()
    
    # split the line on whitespace
    words = line.split()
    
    # create couples of words, one next to another, per line
    coupleslist = couples(words)

    for word in coupleslist:
        print '%s\t%s' % (word, "1")
