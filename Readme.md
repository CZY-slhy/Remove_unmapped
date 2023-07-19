# RIP-seq document

## RIP-seq

&ensp;&ensp;RIP-seq（RNA immunoprecipitation with next generation sequencing，RNA免疫共沉淀结合高通量测序技术）是在转录组层面研究细胞内RNA与蛋白结合情况的技术，是了解转录后调控网络动态过程的有力工具。 这种技术运用针对目标蛋白的抗体把相应的RNA-蛋白复合物沉淀下来，然后经过分离纯化，对结合在复合物上的RNA进行测序分析。RIP-seq在全转录组范围内对蛋白结合位点进行筛选与鉴定，系统、全面、精准挖掘结合位点，深度解析目标RNA种类以及其与蛋白的相互作用。

## Quick start

1. Edit the file `KC_metadata_rip.xls` and fill in the config information of your project, for details, see template

2. The following shell scripts are generated under the project path

```
    /nas/Pipeline/kcrip/rip/bin/python \ 
    /nas/Pipeline/kcrip/rip/script/python/init.py \ 
    -I KC_metadata_rip.xls
```
 
&ensp;&ensp;&ensp;&ensp;**The following files are generated under the project path**

```
    1.Prepare.20220725150158.sh
    2.QC.20220725150158.sh
    3.Mapping.20220725150158.sh
    4.CoreAnalysisis.20220725150158.sh
    5.DiffPeak.20220725150158.sh
    report.20220725150158.sh
    upload.20220725150158.sh
    byebye.20220725150158.sh
```

3. Execute the following command to start running the pipeline

```
    bash 1.Prepare.20220725150158.sh
    bash 2.QC.20220725150158.sh
    bash 3.Mapping.20220725150158.sh
    bash 4.CoreAnalysisis.20220725150158.sh
    bash 5.DiffPeak.20220725150158.sh
```

<br>
<br>
<br>
<br>

4. Execute the following command to package the analysis report

```
    bash report.20220725150158.sh
```
&ensp;&ensp;&ensp;&ensp;**The final project report will be generated in：**<br>

```
    project/report/build/KC2022-G0656-20220725150158
    project/report/build/KC2022-G0656-20220725150158.zip
```

5. Execute the following command to upload data

```
    bash upload.20220725150158.sh
```

6. Execute the following command to clean up the completed projects

```
    bash byebye.20220725150158.sh
```


