#mcc_av_clust.py

import sys

mcc_in=sys.stdin.read()

mcc=mcc_in.split('\n')[:-1]

# test:
#print mcc[0]
#print mcc[-1] 
#print mcc[0].split(' ')


##############
#printf "$tp $fp $fn $tn %1.3f %1.3f $name %1.3f %1.3f $comm\n", $ppv, $sens, $cc, sqrt($sens*$ppv);
# 5 5 0 341 0.500 1.000 AJ426432.1/1593-1619 0.702 0.707 IRE      Published; PMID:8710843

fam={}
fam_keys=[]
#print mcc[0].split(' ')[9].split('\t')
for e in mcc:
	x=e.split(' ')[9].split('\t')[0]
	if x in fam:
		fam[x].append(e)		
	else:
		fam[x]=[e]
		fam_keys.append(x)

#print len(fam_keys)
#print fam_keys


#################

print 'average values:'
print 'fam\t#members\tppv\tsens\tmcc\tsqrt(sens*ppv)'

w=3
ppv_t=0
sens_t=0
mcc_t=0
sqrt_t=0

for e in fam_keys:
	z=len(fam[e])
	ppv_sum=0
	sens_sum=0
	mcc_sum=0
	sqrt_sum=0
	for k in fam[e]:
		x=k.split(' ')
		ppv_sum+=float(x[4])
		sens_sum+=float(x[5])
		mcc_sum+=float(x[7])
		sqrt_sum+=float(x[8])
	ppv_t+=ppv_sum/z
	sens_t+=sens_sum/z
	mcc_t+=mcc_sum/z
	sqrt_t+=sqrt_sum/z
	print '%s\t%s\t%s\t%s\t%s\t%s'%(e.replace('_','\_'),z,round(ppv_sum/z,w),round(sens_sum/z,w),round(mcc_sum/z,w),round(sqrt_sum/z,w))
zz=len(fam_keys)
print 'total\t%s\t%s\t%s\t%s\t%s'%(len(mcc),round(ppv_t/zz,w),round(sens_t/zz,w),round(mcc_t/zz,w),round(sqrt_t/zz,w))
	




