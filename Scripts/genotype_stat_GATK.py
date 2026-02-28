from posixpath import split
import re
import sys
from unittest import result
#astr = 'A_C_CCC_A_G_T'

def replace_sub(astr):
    aa=re.search('(_[A-Z])', astr) 
    if aa is not None:
        replace_str = aa.group(1).replace('_','-')
        newstr = re.sub(aa.group(1), replace_str, astr)
        newre = re.search('(_[A-Z])', newstr)
        while newre is not None:
            replace_str = newre.group(1).replace('_','-')
            newstr = re.sub(newre.group(1), replace_str, newstr)
            newre = re.search('(_[A-Z])', newstr)
    else:
        newstr = astr

    return newstr

# read genotypes
with open('genotypes.txt', 'r') as ifl:
    genotypes = [x.strip() for x in ifl.readlines()]  

# read sample name
samples = []
with open('sample_name.txt', 'r') as ifl:
    for s in ifl.readlines():
        samples.append(s.strip())

sample_num = len(samples)
# print(samples[:10])

# process genotypes
afile=sys.argv[1]
case1_index=0
case2_index=1
case3_index=2
columns_before = 12 # Number of columns before the sample columns
with open(afile,'r') as ifl:
    num = 0
    header = ifl.readline()
    for l in ifl.readlines():
        num += 1
        # l = replace_sub(l)
        line = l.strip().split('\t')
        # case1  ## Case1 represents samples in the cohort diagnosed with epilepsy or febrile seizures (FS)
        case1_result = []
        case1_sample = replace_sub(line[case1_index]).split('_')
        for sample in case1_sample:
            case1_genotype = sample.split(':')[0]
            if case1_genotype != '0/0' and case1_genotype != './.':
                case1_result.append(case1_genotype)
        case1_result = list(set(case1_result))
        # case2 # Case2 represents samples in the cohort with other neurological symptoms (e.g., speech delay)
        case2_result = []
        case2_sample = replace_sub(line[case2_index]).split('_')
        for sample in case2_sample:
            case2_genotype = sample.split(':')[0]
            if case2_genotype != '0/0' and case2_genotype != './.':
                case2_result.append(case2_genotype)
        case2_result = list(set(case2_result))
        # case3 # Case3 represents phenotypically normal samples in the cohort
        case3_result = []
        case3_sample = replace_sub(line[case3_index]).split('_')
        for sample in case3_sample:
            case3_genotype = sample.split(':')[0]
            if case3_genotype != '0/0' and case3_genotype != './.':
                case3_result.append(case3_genotype)
        case3_result = list(set(case3_result))
        #print(case1_result, case2_result, case3_result)
        final_result = list(set(case1_result) - set(case2_result) - set(case3_result))   #Case1
        
        if len(final_result) != 0:
            # result_dict stores information for all samples in the current row
            result_dict = {} 
            for genotype in genotypes:
                result_dict[genotype] = {'store_samples': [], 'store_depths': [], 
                                        'store_gqs': [], 'store_pls': []}
                # Add genotype information
                result_dict[genotype]['store_samples'].append(genotype)
                result_dict[genotype]['store_depths'].append(genotype)
                result_dict[genotype]['store_gqs'].append(genotype)
                result_dict[genotype]['store_pls'].append(genotype)

            # Start iterating over each sample
            for index in range(sample_num):
                # print(line[0:10])
                split_line = line[index+columns_before].split(':')
                # print(split_line)
                genotype = split_line[0]
                # print(genotype)

                # Add samplename, GQ, PL
                # Add depth
                if genotype == '0/0':
                    sample_name = samples[index]
                    dp1, dp2 = split_line[1], split_line[2]
                    store_dp = '%s-'%(dp2)+'%s'%(dp1)
                    gq = split_line[3]
                    store_gq = '%s'%(gq)
                    if len(split_line) >5 :
                        pl = split_line[6]
                    else:
                        pl = split_line[4]
                    store_pl = '%s'%(pl)

                elif genotype == './.':
                    sample_name = samples[index]
                    if len(split_line) == 2 :
                        dp1 = split_line[1]
                        gq = []
                        pl = []
                        store_dp = '%s'%(dp1)
                        store_gq = []
                        store_pl = []
                    elif len(split_line) == 5 :
                        dp1, dp2 = split_line[1], split_line[2]
                        gq = split_line[3]
                        pl = split_line[4]
                        store_dp = '%s-'%(dp2)+'%s'%(dp1)
                        store_gq = '%s'%(gq)
                        store_pl = '%s'%(pl)
                    elif len(split_line) == 6 :
                        dp1, dp2 = split_line[1], split_line[2]
                        gq = split_line[3]
                        pl = []
                        store_dp = '%s-'%(dp2)+'%s'%(dp1)
                        store_gq = '%s'%(gq)
                        store_pl = []
                    elif len(split_line) == 7 :
                        dp1, dp2 = split_line[1], split_line[2]
                        gq = split_line[3]
                        pl = split_line[6]
                        store_dp = '%s-'%(dp2)+'%s'%(dp1)
                        store_gq = '%s'%(gq)
                        store_pl = '%s'%(pl)
                else:
                    sample_name = samples[index]
                    dp1, dp2 = split_line[1], split_line[2]
                    dp11=dp1.split(',')[0]
                    dp12=dp1.split(',')[1]
                    if (dp11 != '.') and (dp12 != '.'):
                        dp1 = [int(x) for x in dp1.split(',')] 
                        if (dp2 == '0') or (sum(dp1) == 0) or (genotype != '0/1' and genotype != '1/1'):
                            store_dp = '%s-'%(dp2)+','.join([str(x) for x in dp1])
                        else:
                            ratio = dp1[1] / (sum(dp1))
                            store_dp = '%s,%.2f'%(dp2,ratio)
                    else:
                        store_dp = '%s-'%(dp2)+'%s'%(dp1)
                    gq = split_line[3]
                    if len(split_line) >5 :
                        pl = split_line[6]
                    else:
                        pl = split_line[4]
                    store_gq = '%s'%(gq)
                    store_pl = '%s'%(pl)

                result_dict[genotype]['store_samples'].append(sample_name)
                result_dict[genotype]['store_gqs'].append(store_gq)
                result_dict[genotype]['store_pls'].append(store_pl)
                result_dict[genotype]['store_depths'].append(store_dp)
            
            
            print('\t'.join(line), end='')
            for genotype, infos in result_dict.items():
                store_samples = infos['store_samples']
                store_depths = infos['store_depths']
                store_gqs = infos['store_gqs']
                store_pls = infos['store_pls']

                num_store_samples = len(store_samples) - 1
                print('\t%s\t%s\t%s\t%s\t%s'%(':'.join(store_samples), num_store_samples, ':'.join(store_depths),':'.join([str(x) for x in store_gqs]),':'.join([str(x) for x in store_pls])), end='')
            print()
