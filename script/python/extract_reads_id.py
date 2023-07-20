#!/usr/bin/python
# _*_coding:utf-8_*_
import os
import re
import argparse

parser = argparse.ArgumentParser(
    description="This script is used to get unmappedid of UID project",
    formatter_class=argparse.RawTextHelpFormatter,
    usage="python extract_reads_id.py --unmapped {unmapped_mate1} "
                "--readsid {reads_id} --odir {unmapped_id}",
)
parser.add_argument(
    "-um",
    "--unmapped",
    dest="unmapped",
    type=str,
    default=False,
    help="The unmapped_mate file",
    required=True,
)
parser.add_argument(
    "-rs",
    "--readsid",
    dest="readsid",
    type=str,
    default=False,
    help="The conversion between UID reads and raw reads",
    required=True,
)
parser.add_argument(
    "-o",
    "--odir",
    dest="odir",
    type=str,
    default=False,
    help="The result file",
    required=False,
)

argv = vars(parser.parse_args())
unmapped = argv["unmapped"]
readsid = argv["readsid"]
odir = argv["odir"]

def get_unmappedid(unmapped, readsid, odir):
    unmappedSet = set() 
    trueunmappedSet = set() 

    unmappedid = open(unmapped, "r")
    for line in unmappedid:
        if line.startswith('@'):
            unmappedSet.add(line.split()[0])
    unmappedid.close()

    convertid = open(readsid, "r")
    for line in convertid:
        lines = line.strip().split('\t')
        if lines[0] in unmappedSet:
                for i in lines[1:]:
                    trueunmappedSet.add(i)
    convertid.close()

    outdir = open(odir, "w")
    for readsid in trueunmappedSet:
        outdir.write(readsid + '\n')
    outdir.close()

def main():

    get_unmappedid(unmapped, readsid, odir)


if __name__ == "__main__":
    main()

