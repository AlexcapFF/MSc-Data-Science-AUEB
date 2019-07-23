#!/usr/bin/env python
from pyspark import SparkContext, SparkConf
import sys
import re
import string
import subprocess
# from operator import add
import pyspark
import sys
import re
import itertools

def couples(lst):
    # remove leading and trailing whitespace, symbol characters and lowercase
    lst = lst.strip()
    lst = re.sub(r"[^a-zA-Z0-9]+", ' ', lst).lower()
    # split the line on whitespace
    words = lst.split()
    # create pairs of each word per line
    return list(itertools.permutations(words,2))

if __name__ == "__main__":
    conf = SparkConf().setAppName("Test").setMaster("yarn")
    sc = SparkContext(conf=conf)
    out_path = "hdfs:///data/shakespeare_word_count_part4"
    subprocess.call(["hdfs", "dfs", "-rm", "-r", out_path])
    # load txt into an RDD named lines
    lines = sc.textFile("hdfs:///data/shakespeare.txt")
    # apply FlatMap on RDD lines and call couples
    pairs = lines.flatMap(couples)
    # map each pair to 1
    wc = pairs.map(lambda x: (x,1))
    # reducer to sum the 1s of each key
    counts = wc.reduceByKey(lambda x,y: x+y)
    counts.saveAsTextFile("hdfs:///data/shakespeare_word_count_part4")
