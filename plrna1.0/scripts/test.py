
import sys

data=sys.stdin.readlines()

#print data[0]
#print data[-1]

for e in data:
	x=e.split('\t')
	print len(x[1])


