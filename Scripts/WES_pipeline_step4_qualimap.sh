bam=/public/home/fan_lab/suke/Epilepsy/WES/${sample}_hg19_sorted.bam
out=/public/home/fan_lab/suke/Epilepsy/WES/
bed=/public/home/fan_lab/suke/Epilepsy/WES/bed_file/bed

cd /public/home/fan_lab/suke/Epilepsy/WES/

qualimap bamqc -gff ${bed} -bam ${bam} -outformat  HTML  --java-mem-size=20G   -outdir ${out}/${sample}_hg19_sorted_stats
