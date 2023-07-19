#!/usr/bin/env python
# coding: utf-8


if UID:
    rules.all.rule.set_input(
        expand(PROJECT_DIR + "/remove_reads_id/{samplename}.id.xls", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.remove.stat.xls", samplename=SAMPLENAMES)
    )


    rule Unmapped_id:
        input:
            reads_id = PROJECT_DIR + "/UID/{samplename}.reads_ids.txt",
            unmapped_mate1 = PROJECT_DIR + "/mapping/{samplename}/Unmapped.out.mate1"
        output:
            unmapped_id = PROJECT_DIR + "/remove_reads_id/{samplename}.id.xls"
        params:
            ExtractReadsid = softconfig["Unmapped_id"]["soft"]["ExtractReadsid"]["path"],
            container = softconfig["Unmapped_id"]["singularity"]["py3"]["path"],
            conargs = softconfig["Unmapped_id"]["singularity"]["py3"]["conargs"],
            python3 = softconfig["Unmapped_id"]["singularity"]["py3"]["soft"]["python3"]["cmd"],
            singularity = softconfig["envs"]["singularity"]
        run:
            shell(
                "{params.singularity} {params.conargs} {BIND_DIRS} {params.container} {params.python3} "
                "{params.ExtractReadsid} --unmapped {input.unmapped_mate1} "
                "--readsid {input.reads_id} --odir {output.unmapped_id}"
            )


    rule remove_Unmapped_id:
        input:
            r1 = PROJECT_DIR + "/raw/{samplename}.R1.fq.gz",
            r2 = PROJECT_DIR + "/raw/{samplename}.R2.fq.gz",
            unmapped_id = PROJECT_DIR + "/remove_reads_id/{samplename}.id.xls"
        output:
            r1 = PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz",
            r2 = PROJECT_DIR + "/raw_clean/raw/{samplename}.R2.fq.gz",
            stat = PROJECT_DIR + "/raw_clean/raw/{samplename}.remove.stat.xls"
        params:
            UnmappFilt = softconfig["remove_Unmapped_id"]["soft"]["Filt"]["path"]
        run:
            shell(
                "{params.UnmappFilt} -readsid {input.unmapped_id} "
                "-ir1 {input.r1} -ir2 {input.r2} -or1 {output.r1} -or2 {output.r2} -log {output.stat}"
            )


else:
    rules.all.rule.set_input(
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz", samplename=SAMPLENAMES),
        expand(PROJECT_DIR + "/raw_clean/raw/{samplename}.remove.stat.xls", samplename=SAMPLENAMES)
    )


    rule remove_Unmapped_id:
        input:
            r1 = PROJECT_DIR + "/raw/{samplename}.R1.fq.gz",
            r2 = PROJECT_DIR + "/raw/{samplename}.R2.fq.gz",
            unmapped_id = PROJECT_DIR + "/mapping/{samplename}/Unmapped.out.mate1"
        output:
            r1 = PROJECT_DIR + "/raw_clean/raw/{samplename}.R1.fq.gz",
            r2 = PROJECT_DIR + "/raw_clean/raw/{samplename}.R2.fq.gz",
            stat = PROJECT_DIR + "/raw_clean/raw/{samplename}.remove.stat.xls"
        params:
            UnmappFilt = softconfig["remove_Unmapped_id"]["soft"]["Filt"]["path"]
        run:
            shell(
                "{params.UnmappFilt} -readsid {input.unmapped_id} "
                "-ir1 {input.r1} -ir2 {input.r2} -or1 {output.r1} -or2 {output.r2} -log {output.stat}"
            )