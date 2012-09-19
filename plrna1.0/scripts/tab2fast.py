# tab2fasta.py
# S/ren M/rk
# 01/06/2012

import sys

input=open(sys.argv[1])
data_in=input.read()
input.close()

name=sys.argv[1]

data=data_in.split('\n')[:-1]

i=1
for e in data:
	place='../data/fasta/%s.%s'%(name,i)
	x=e.split('\t')
	seq=''
	preseq=x[1].lower()
	out_data= open(place, 'w')
	out_data.write('>')
	out_data.write('\n')
	out_data.write(preseq)
	out_data.close()
	i+=1



