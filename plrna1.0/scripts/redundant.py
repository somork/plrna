# namepred.py
# S/ren M/rk
# 04/09/2012

import sys

predicted_in=sys.stdin.read()

predicted=predicted_in.split('\n')[:-1]

print len(predicted)
print predicted[0]


predicted_d={}

redundant_p=0
redundant_l=[]
for e in predicted:
	x=e.split('\t')
	if x[1] in predicted_d:
		redundant_p+=1
		predicted_d[x[1]].append(e)
		redundant_l.append(x[1])
	else:
		predicted_d[x[1]]=[e]

print redundant_p

print len(predicted_d)

for e in redundant_l:
	print predicted_d[e]



