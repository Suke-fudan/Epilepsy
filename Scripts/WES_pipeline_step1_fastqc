#Integrity check
md5sum -c ./*.md5

#fastqc

threads=2
outdir=/public/home/fan_lab/suke/Epilepsy/WES/fastqc
fastqc -f fastq -t ${threads} -o ${outdir}  ${sample}_combined_R1.fastq.gz ${sample}_combined_R2.fastq.gz
