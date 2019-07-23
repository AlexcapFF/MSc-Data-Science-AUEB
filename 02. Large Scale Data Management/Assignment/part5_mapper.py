#!/usr/bin/env python
import sys
import re
import itertools

# get all lines from STDIN
for line in sys.stdin:
    # remove leading and trailing whitespace, symbol characters and lowercase
    line = line.strip()
    line = re.sub(r"[^a-zA-Z0-9]+", ' ', line).lower()
   
    # split the line on whitespace
    words = line.split()
    
    #create all triplets of words per line
    triplets = list(itertools.permutations(words,3))

    for triplets_words in triplets:
        print '%s\t%s' % (triplets_words, "1")
