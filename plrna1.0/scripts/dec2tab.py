# dec2tab2.py
# S/ren M/rk
# 01/06/2012

import sys

data_in=sys.stdin.read()

input=open(sys.argv[1])
names_in=input.read()
input.close()

data=data_in.split('[')[1:]

names=names_in.split('\n')[:-1]

#print 'names:'
#print names[0]
#print names[1]
#print names[-1]
#print len(names)

d_list=[]
for e in data:
	d_list.append(e.split(']')[0])

#print 'd_list:'
#print d_list[0]
#print d_list[1]
#print d_list[-1]
#print len(d_list)

#print d_list[0::2]
#print len(d_list[0::2])
#print d_list[1::2]
#print len(d_list[1::2])

the_list=[]
for i in range(len(names)):
	the_list.append((int(names[i].split('.')[-1]),names[i],d_list[0::2][i],d_list[1::2][i]))

#print 'the_list:'
#print the_list[0]
#print the_list[1]
#print the_list[-1]
#print len(the_list)

the_list.sort()

for e in the_list:
	n=e[1]
	seq=e[2].replace(',','').upper()
	ann=e[3].replace(',','').replace('<','(').replace('>',')').replace(':','.')
	print '%s\t%s\t%s'%(n,seq,ann)




