

python genotype_stat_GATK.py GATK_Exon_filter_split_head.vcf > GATK_Exon_filter_split_head_stat.vcf  ## genotype_stat_GATK.py is provided as a separate file
cat GATK_Exon_filter_split.vcf |awk -F '\t' '{for(a=10;a<=NF;a++){split($a,b,":");print b[1],"\n"}}' |sort |uniq -c >genotypes.stat
