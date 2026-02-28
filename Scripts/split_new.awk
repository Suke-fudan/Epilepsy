#Splitting multi-allelic VCF records into bi-allelic records with adjusted annotations
#!/usr/bin/awk -f
#usage: 
#   1. chmod +x scripts.awk; ./scripts.awk file
#   2. awk -f scripts.awk file

{
    FS="\t"
	    split($5,alts,",");

		    if(length(alts)> 1) {
			        split($8,annos,"ANNOVAR_DATE");

					        for (i=1; i<=length(alts); i++) {
							            newID=$1"_"$2"_ALT_"i
							            newalt=alts[i]
										            newanno=annos[1]"ANNOVAR_DATE"annos[i+1];
													            printf("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t",$1,$2,newID,$4,newalt,$6,$7,newanno);
																            for (j=9;j<NF;j++) {
																			                printf("%s\t",$j);
																							            }
																										            printf("%s\n",$NF);
																													        }
																															    } else {
																																        print $0
																																		    }
																																			}
