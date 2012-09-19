# rnafold2tab.py
# S/ren M/rk
# 13/06/2012

import sys

data_in=sys.stdin.read()[:-1]

d={}
d_keys=[]

data=data_in.split('>')[1:]

input=open(sys.argv[1])
names_in=input.read()
input.close()

names=names_in.split('\n')[:-1]

the_list=[]

#i=0
for i in range(len(data)):
	#i+=1
	seq=''
	score=0
	struc=''
	x=data[i].split('\n') 
	for k in x[1::2]:
		seq+=k
	for k in x[2::2]:
		struc+=k.split(' ')[0]
	#for k in x[2::2]:
	#	score+=float(k.split(' ')[1].split('(')[1].split(')')[0])
	#score='score'
	#print 'rna_%s\t%s\t%s\t%s'%(i,seq,struc,score) 
	the_list.append((int(names[i].split('.')[-2]),names[i],seq,struc))

the_list.sort()

for e in the_list:
	#s=e[2].split('\t')
	#seq=e[2].split()
	#ann=e[3].replace(',','').replace('<','(').replace('>',')').replace(':','.')
	print '%s\t%s\t%s'%(e[1],e[2],e[3])


