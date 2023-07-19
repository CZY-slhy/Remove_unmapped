#!/usr/bin/env python
# coding: utf-8


import os
import sys
import pathlib
from collections import defaultdict
import yaml


try:
    smkindex = sys.argv.index("-ps")
except ValueError:
    smkindex = sys.argv.index("--snakefile")
snakefile = sys.argv[smkindex+1]
currdir = os.path.abspath(os.path.dirname(snakefile))
parentdir = pathlib.Path(currdir).parent

RULE_DIR = os.path.join(parentdir, "pipeline")
config_file_path = os.path.join(parentdir, "pipeline.yaml")

config_file = open(config_file_path, "r")
softconfig = yaml.load(config_file, Loader=yaml.FullLoader)
config_file.close()

PROJECT_DIR = config["PROJECT_DIR"]

BIND_DIRS = [os.sep.join(x.split(os.sep)[:2]) for x in [PROJECT_DIR, str(parentdir), "/nas/"]]
BIND_DIRS = " ".join(["-B {x}:{x}".format(x=x) for x in set(BIND_DIRS)])

SAMPLES = config["SAMPLES"]
SAMPLENAMES = sorted(list(SAMPLES.keys()))

UID = config["UID"]

rule all:
    input:
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R2.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.remove.stat.xls", samplename=SAMPLENAMES)


include: RULE_DIR + "/Remove.unmapped.reads.snakefile.smk"
