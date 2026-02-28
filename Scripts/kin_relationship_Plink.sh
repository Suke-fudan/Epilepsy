/public/home/fan_lab/suke/softwares/plink/plink --vcf epilepsy_cohort.HC.snps.indels.VQSR.vcf --make-bed --out family-ID
/public/home/fan_lab/suke/softwares/plink/plink --bfile family-ID --indep-pairwise 50 10 0.1
/public/home/fan_lab/suke/softwares/plink/plink --bfile family-ID --extract plink.prune.in --make-bed --out prunedData
/public/home/fan_lab/suke/softwares/plink/plink --bfile prunedData --genome
