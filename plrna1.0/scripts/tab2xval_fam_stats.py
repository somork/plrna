# tab2xval_fam_stats.py
# S/ren M/rk
# 28/08/2012

import sys
import random

input=open(sys.argv[1])
data_in=input.read()
input.close()

name=sys.argv[1]

partitions=int(sys.argv[2])

data=data_in.split('\n')[:-1]


fam={}
fam_keys=[]

#test:
#print data[0]
#print data[-1]
#print data[0].split('\t')[3]

for e in data:
        x=e.split('\t')[3]
        if x in fam:
                fam[x].append(e)
        else:
                fam[x]=[e]
                fam_keys.append(x)

print len(fam_keys)
print fam_keys
for e in fam_keys:
	print '%s:\t%s'%(e,len(fam[e]))


