threads=2
trimadap-mt -p ${threads} ${sample}_combined_R1.fastq.gz  | gzip  >/WES/trimadap_fastq/${sample}_combined_R1_trimadap.fastq.gz
trimadap-mt -p ${threads} ${sample}_combined_R2.fastq.gz | gzip  >/WES/trimadap_fastq/${sample}_combined_R2_trimadap.fastq.gz
