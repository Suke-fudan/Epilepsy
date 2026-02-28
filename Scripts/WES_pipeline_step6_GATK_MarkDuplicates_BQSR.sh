threads=2
ref=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/ucsc.hg19.fasta
GATK_bundle=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19
outdir=/public/home/fan_lab/suke/Epilepsy/WES/GATK_hg19_output
bam=/public/home/fan_lab/suke/Epilepsy/WES/hg19_bam
bed=/public/home/fan_lab/suke/Epilepsy/WES/bed_file/bed
dbsnp=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/dbsnp_138.hg19.vcf

#MarkDuplicates
time gatk MarkDuplicates \
  -I $bam/${sample}_hg19_sorted.bam \
  -M $outdir/data_pre/${sample}_hg19_sorted_markdup_metrics.txt \
  -O $outdir/data_pre/${sample}_hg19_sorted_markdup.bam && echo "** ${sample}.sorted_head_markdup.bam MarkDuplicates done **"
time samtools index -@ ${threads} $outdir/data_pre/${sample}_hg19_sorted_markdup.bam && echo "** ${sample}.sorted_head_markdup.bam index done **"

#BQSR
time gatk BaseRecalibrator \
    -R $ref \
	-I $outdir/data_pre/${sample}_hg19_sorted_markdup.bam \
    --known-sites $GATK_bundle/1000G_phase1.snps.high_confidence.hg19.sites.vcf \
    --known-sites $GATK_bundle/1000G_phase1.indels.hg19.sites.vcf \
    --known-sites $GATK_bundle/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf \
    --known-sites $GATK_bundle/dbsnp_138.hg19.vcf \
    -L $bed \
    -O $outdir/data_pre/${sample}_hg19_sorted_markdup_recal_data.table && echo "** ${sample}.sorted_head_markdup_recal_data.table done **"

time gatk ApplyBQSR \
    --bqsr-recal-file $outdir/data_pre/${sample}_hg19_sorted_markdup_recal_data.table \
    -R $ref \
    -L $bed \
    -I $outdir/data_pre/${sample}_hg19_sorted_markdup.bam \
    -O $outdir/data_pre/${sample}_hg19_sorted_markdup.BQSR.bam && echo "** ApplyBQSR ${sample}.sorted_head_markdup.BQSR.bam done **"
time samtools index -@ ${threads} $outdir/data_pre/${sample}_hg19_sorted_markdup.BQSR.bam && echo "** ${sample}.sorted_head_markdup.BQSR.bam index done **"
