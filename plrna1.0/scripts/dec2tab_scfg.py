# dec2tab_scfg.py
# S/ren M/rk
# 01/06/2012

import sys

data_in=sys.stdin.read()

input=open(sys.argv[1])
names_in=input.read()
input.close()

data=data_in.split('\n')[:-1]

names=names_in.split('\n')[:-1]

the_list=[]
for i in range(len(names)):
	the_list.append((int(names[i].split('.')[-2]),names[i],data[i]))

the_list.sort()

for e in the_list:
	s=e[2].split('\t')
	#seq=e[2].split()
	#ann=e[3].replace(',','').replace('<','(').replace('>',')').replace(':','.')
	print '%s\t%s\t%s'%(e[1],s[1],s[2])




