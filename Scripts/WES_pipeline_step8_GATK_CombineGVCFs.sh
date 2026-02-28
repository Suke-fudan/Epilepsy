#This script outputs a sample list
echo "/public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/data/${i}.HC.g.vcf.gz" >>/public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/input.list;done

#CombineGVCFs needs to be run separately for each chromosome.
outdir=/public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split
bed=/public/home/fan_lab/suke/Epilepsy/WES/bed_file/bed.${sample}.hg19.bed  # "sample" refers to the chromosome name (e.g., chr1, chr2)
ref=/public/home/fan_lab/Fan_lab_share/GATK_resource/hg19/ucsc.hg19.fasta
list=/public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/input.list


time gatk --java-options "-Xmx128G" CombineGVCFs \
  -R $ref \
  --variant $list \
  -L $bed \
  -O $outdir/epilepsycohort.${sample}.g.vcf.gz && echo "** cohort.GVCF.HC.${sample}.g.vcf.gz done **"

#Merge
cd /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split
gatk MergeVcfs -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr1.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr2.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr3.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr4.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr5.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr6.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr7.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr8.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr9.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr10.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr11.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr12.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr13.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr14.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr15.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr16.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr17.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr18.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr19.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr20.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr21.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chr22.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chrX.vcf.gz -I /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.chrY.vcf.gz -O /public/home/fan_lab/suke/Epilepsy/WES_trios/GATK_output/Combine/Combine_split/epilepsycohort.vcf.gz && echo "** Mergevcf done **"
