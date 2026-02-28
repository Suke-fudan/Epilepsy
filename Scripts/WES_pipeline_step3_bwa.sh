ref=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/ucsc.hg19.fasta
threads=2
cd /WES/trimadap_fastq
bwa mem -t ${threads} ${ref} -R "@RG\tID:${sample}\tPL:illumina\tSM:${sample}" ${sample}_combined_R1_trimadap.fastq.gz ${sample}_combined_R2_trimadap.fastq.gz | samblaster | samtools view  -@ ${threads} -Sb - |samtools sort -@ ${threads} -O bam -o /public/home/fan_lab/suke/Epilepsy/WES/hg19_bam_file/${sample}_hg19_sorted.bam -
