import sys
import math


input=open(sys.argv[1])
data_in=input.read()
input.close()

data=data_in.split('\n')

print 'time:'
for e in data[::2]:
	print e
print
print 'memory:'
for e in data[1::2]:
	print e


