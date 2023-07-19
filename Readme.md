# Remove unmapped

## annotation

1、yaml文件中需要有UID参数注明是否为UID项目，具体可见project.yaml示例

2、对于不需要剔除的样本，可直接在yaml文件中注释掉对应sample，具体可见project.yaml示例

## quick test

可直接试运行以下命令进行测试

```
/project/chenzhiying/Remove_unmapped_202307/bin/snakemake \   
-ps /project/chenzhiying/Remove_unmapped_202307/master/Master.Remove.snakefile.smk \   
--configfile /project/chenzhiying/KC2023-H0638-test/KC2023-H0638.20230717161445.yaml \
-j 3 --directory /project/chenzhiying/KC2023-H0638-test --latency-wait 300 \  
--cluster 'sbatch -c {cluster.threads} -o {cluster.stdout} -e {cluster.stderr} --parsable' \  
--cluster-config /project/chenzhiying/Remove_unmapped_202307/pipeline.yaml \                      
--cluster-cancel scancel --use-singularity --singularity-args '-B /nas:/nas -B /project:/project'  
```
