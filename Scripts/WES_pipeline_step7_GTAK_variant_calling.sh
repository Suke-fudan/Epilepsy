ref=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/ucsc.hg19.fasta
GATK_bundle=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19
outdir=/public/home/fan_lab/suke/Epilepsy/WES/GATK_hg19_output
bam=/public/home/fan_lab/suke/Epilepsy/WES/hg19_bam
bed=/public/home/fan_lab/suke/Epilepsy/WES/bed_file/bed

# variants calling
time gatk HaplotypeCaller \
     --emit-ref-confidence GVCF \
     -R $ref \
     -I $outdir/data_pre/${sample}_hg19_sorted_markdup.BQSR.bam \
     -L $bed \
     -O $outdir/data/${sample}.HC.g.vcf.gz && echo "** GVCF ${sample}.HC.g.vcf.gz done **"
