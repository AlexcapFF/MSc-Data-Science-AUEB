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
    
    # create all couples of words per line 
    couples = list(itertools.permutations(words,2))

    for couple_words in couples:
        print '%s\t%s' % (couple_words, "1")
