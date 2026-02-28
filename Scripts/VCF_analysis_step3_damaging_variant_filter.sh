cat GATK_Exon_filter_split_head_stat.vcf |perl -lane 'if(/AF_eas=(.*)?;AF_fin.*?1000g2015aug_eas=(.*)?;CLNALLELEID/){if(($1 <= 0.001||$1 eq "\.")&&($2 <= 0.001||$2 eq "\.")){print $_}}'  >AF.vcf
cat AF.vcf | 
