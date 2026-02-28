cat epilepsy_cohort.HC.snps.indels.VQSR.vcf |awk '{if($0 !~ /^##/){print $0}}' | perl -lane 'if(/^#/){print $_}if($F[6]=~/PASS/){print $_}' >epilepsy_cohort_PASS.vcf
#Annotation
vcf=epilepsy_cohort.vcf
threads=8
out_name=epilepsy_cohort

/public/home/fan_lab/suke/softwares/annovar_20210909/annovar/table_annovar.pl ${vcf} /public/home/fan_lab/suke/softwares/annovar_20210909/annovar/humandb -thread ${threads} -buildver hg19 -out ${out_name} -remove -protocol refGene,cytoBand,avsnp150,avsift,dbnsfp42a,mcap13,revel,dbscsnv11,exac03,exac03nonpsych,gene4denovo201907,gnomad211_exome,1000g2015aug_all,1000g2015aug_eas,clinvar_20230226,intervar_20180118 -operation g,r,f,f,f,f,f,f,f,f,f,f,f,f,f,f -nastring . -vcfinput
