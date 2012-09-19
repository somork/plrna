# lst2tab.py
# S/ren M/rk
# 11/09/2012

import sys

data_in=sys.stdin.read()

data=data_in.split('\n')[:-1]

i=1
for e in data:
	x=e.replace(',','')
	print '%s\t%s'%(i,x)
	i+=1



