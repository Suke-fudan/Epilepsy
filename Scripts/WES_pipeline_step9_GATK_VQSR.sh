#VQSR
#Make sure there is sufficient disk space in the working directory before running this step

bed=/public/home/fan_lab/suke/Epilepsy/WES/bed_file/sorted.bed
ref=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/ucsc.hg19.fasta
indir=/public/home/fan_lab/suke/Epilepsy/WES/GATK_output
GATK_bundle=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19
outdir=/public/home/fan_lab/suke/Epilepsy/WES/GATK_output/VQSR

time /public/home/fan_lab/suke/softwares/gatk-4.0.10.1/gatk VariantRecalibrator \
   -R $ref \
   -V $indir/epilepsycohort.vcf.gz \
   --resource hapmap,known=false,training=true,truth=true,prior=15.0:$GATK_bundle/hapmap_3.3.hg19.sites.vcf \
   --resource omni,known=false,training=true,truth=false,prior=12.0:$GATK_bundle/1000G_omni2.5.hg19.sites.vcf \
   --resource 1000G,known=false,training=true,truth=false,prior=10.0:$GATK_bundle/1000G_phase1.snps.high_confidence.hg19.sites.vcf \
   --resource dbsnp,known=true,training=false,truth=false,prior=2.0:$GATK_bundle/dbsnp_138.hg19.vcf \
   -an QD -an MQ -an MQRankSum -an ReadPosRankSum -an FS -an SOR -an DP \
   -mode SNP \
   -L $bed \
   -O $outdir/epilepsy_cohort.HC.snps.recal \
   --tranches-file $outdir/epilepsy_cohort.HC.snps.tranches \
   --rscript-file $outdir/epilepsy_cohort.HC.snps.plots.R \
   
time /public/home/fan_lab/suke/softwares/gatk-4.0.10.1/gatk ApplyVQSR \
   -R $ref \
   -V $indir/epilepsycohort.vcf.gz \
   -L $bed \
   --truth-sensitivity-filter-level 99.0 \
   --tranches-file $outdir/epilepsy_cohort.HC.snps.tranches \
   --recal-file $outdir/epilepsy_cohort.HC.snps.recal \
   -mode SNP \
   -O $outdir/epilepsy_cohort.HC.snps.VQSR.vcf.gz 

time /public/home/fan_lab/suke/softwares/gatk-4.0.10.1/gatk VariantRecalibrator \
   -R $ref \
   -V $outdir/epilepsy_cohort.HC.snps.VQSR.vcf.gz \
   -resource mills,known=true,training=true,truth=true,prior=12.0:$GATK_bundle/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf \
   -resource dbsnp,known=true,training=false,truth=false,prior=2.0:$GATK_bundle/dbsnp_138.hg19.vcf \
   -an QD -an DP -an FS -an SOR -an ReadPosRankSum -an MQRankSum \
   -mode INDEL \
   -L $bed \
   -O $outdir/epilepsy_cohort.HC.snps.indels.recal \
   --tranches-file $outdir/epilepsy_cohort.HC.snps.indels.tranches \
   --rscript-file $outdir/epilepsy_cohort.HC.snps.indels.plots.R \
   
time /public/home/fan_lab/suke/softwares/gatk-4.0.10.1/gatk ApplyVQSR \
   -R $ref \
   -V $outdir/epilepsy_cohort.HC.snps.VQSR.vcf.gz \
   -L $bed \
   --truth-sensitivity-filter-level 99.0 \
   -mode INDEL \
   --tranches-file $outdir/epilepsy_cohort.HC.snps.indels.tranches \
   --recal-file $outdir/epilepsy_cohort.HC.snps.indels.recal \
   -O $outdir/epilepsy_cohort.HC.snps.indels.VQSR.vcf.gz && echo "**snps.indels.VQSR.vcf.gz done**"
