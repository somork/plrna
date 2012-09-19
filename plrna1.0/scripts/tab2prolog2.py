# tab2prolog2.py
# S/ren M/rk
# 01/06/2012

# print ':' not '.' for unpaired nts

import sys

data_in=sys.stdin.read()

data=data_in.split('\n')[:-1]

print '%s # sequences: %s'%('%',len(data))

#print data[0]
#print data[1]
#print data[-1]

for e in data:
	x=e.split('\t')
	print '%s %s\t%s'%('%',x[0],x[3])
	seq=''
	preseq=x[1].lower()
	for k in preseq:
		seq+=','+k
	#print seq[1:]
	struc=''
	prestruc=x[2].replace('(','<').replace(')','>').replace('.',':')
	for l in prestruc:
		struc+=','+l
	print 'model([%s],[%s]).'%(seq[1:],struc[1:])


