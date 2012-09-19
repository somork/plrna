# namepred.py
# S/ren M/rk
# 04/09/2012

import sys

predicted_in=sys.stdin.read()

input=open(sys.argv[1])
golden_in=input.read()
input.close()

golden=golden_in.split('\n')[:-1]
predicted=predicted_in.split('\n')[:-1]

#print len(golden)
#print len(predicted)

for i in range(len(golden)):
	x=golden[i].split('\t')
	y=predicted[i].split('\t')
	print '%s\t%s\t%s'%(x[0],y[1],y[2])

