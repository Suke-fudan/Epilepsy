cat epilepsy_cohort.hg19_multianno.vcf |perl -lane 'if(/Func.refGene=exonic/){print $_}if(/Func.refGene=ncRNA_exonic/){print $_}if(/Func.refGene=splicing/){print $_}' |perl -lane 'if(/ExonicFunc.refGene=frameshift/){print $_}if(/ExonicFunc.refGene=nonframeshift/){print $_}if(/ExonicFunc.refGene=start/){print $_}if(/ExonicFunc.refGene=stop/){print $_}if(/ExonicFunc.refGene=nonsynonymous/){print $_}elsif(/Func.refGene=splicing/){print $_}' |sed 's/ /_/g' > GATK_Exon_filter.vcf
awk -f /public/group_share_data/fan_lab/suke/Epilepsy/VQSR/annovar/split_new.awk GATK_Exon_filter.vcf >GATK_Exon_filter_split.vcf     ## split_new.awk is provided as a separate file
cat epilepsy_cohort.vcf |awk '{if($0 ~ /^#CH/){print}}' >epilepsy_cohort_head.txt
cat epilepsy_cohort_head.txt GATK_Exon_filter_split.vcf >GATK_Exon_filter_split_head.vcf
python genotype_stat_GATK.py GATK_Exon_filter_split_head.vcf > GATK_Exon_filter_split_head_stat.vcf  ## genotype_stat_GATK.py is provided as a separate file
cat GATK_Exon_filter_split.vcf |awk -F '\t' '{for(a=10;a<=NF;a++){split($a,b,":");print b[1],"\n"}}' |sort |uniq -c >genotypes.stat


