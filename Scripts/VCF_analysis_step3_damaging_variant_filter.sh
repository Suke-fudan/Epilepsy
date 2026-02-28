cat GATK_Exon_filter_split_head_stat.vcf |perl -lane 'if(/AF_eas=(.*)?;AF_fin.*?1000g2015aug_eas=(.*)?;CLNALLELEID/){if(($1 <= 0.001||$1 eq "\.")&&($2 <= 0.001||$2 eq "\.")){print $_}}'  >AF.vcf
# damaging1 variants : cause gene disruption (e.g., variants at splicing sites,pre-stop codon gain and stop codon loss, start codon loss, open reading frame shift) 
cat AF.vcf | perl -lane 'if(/ExonicFunc.refGene=frameshift/){print $_}if(/ExonicFunc.refGene=start/){print $_}if(/ExonicFunc.refGene=stop/){print $_}elsif(/Func.refGene=splicing/){print $_}' |awk -v OFS='\t' 'BEGIN{a="damaging1"}{print $0,".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",a}' >AF_damaging1.vcf
# damaging2 variants : damaging missense effect (predicted to have deleterious effects by at least 3 in silico programs or with CADD score ≥ 20 or DANN score ≥ 0.93)
# oNF represents the number of columns in the VCF file to be processed
cat AF.vcf | 

cat damaging1.vcf damaging2.vcf |sort |uniq >damagingtag.vcf
