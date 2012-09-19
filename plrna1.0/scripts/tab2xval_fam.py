# tab2xval.py
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

#print len(fam_keys)
#print fam_keys
#for e in fam_keys:
#	print '%s:\t%s'%(e,len(fam[e]))

part={}
for e in fam_keys:
	if len(fam[e])>9:
		list=fam[e]
		random.shuffle(list)
		for i in range(partitions):
			if i in part:
				part[i].append(list[i::partitions])        		
			else:
				part[i]=[list[i::partitions]]

#for e in part:
#	print len(part[e])

########## output: 
for i in range(partitions):
	place=name+'.part.%s'%str(i+1)
	to_sort=[]
	for j in part[i]:
		for k in j:
			#print k
			to_sort.append((len(k.split('\t')[1]),k))
	to_sort.sort()
	out_data = open(place, 'w')
	for k in to_sort:	
		out_data.write(k[1])
		out_data.write('\n')
	out_data.close()


