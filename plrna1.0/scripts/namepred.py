# namepred3.py
# S/ren M/rk
# 04/09/2012

# using sequences as identifiers:

import sys

predicted_in=sys.stdin.read()

input=open(sys.argv[1])
golden_in=input.read()
input.close()

golden=golden_in.split('\n')[:-1]
predicted=predicted_in.split('\n')[:-1]

golden_d={}
predicted_d={}

golden_n={}

redundant_l=[]

redundant_p=0
for e in predicted:
	x=e.split('\t')
	if x[1] in predicted_d:
		redundant_p+=1
		predicted_d[x[1]].append(e)
		redundant_l.append(x[1])
	else:
		predicted_d[x[1]]=[e]

i=0
redundant_g=0
golden_n_keys=[]
for e in golden:
	i+=1
	x=e.split('\t')
	name=x[0].replace('rnahmm','')
	if x[1] in golden_d:
		redundant_g+=1
		golden_d[x[1]].append((i,e))
		golden_n[name].append(e)		
	else:
		golden_d[x[1]]=[(i,e)]
		golden_n[name]=[e]
		golden_n_keys.append(name)

## to be removed upon completion:

'''

print '# golden names: %s'%len(golden_n)
print golden_n_keys[0]

print '# predictions: %s'%len(predicted)
print '# standards: %s'%len(golden)

print 'redundant predictions: %s'%redundant_p
print 'redundant standard: %s'%redundant_g

print 'p_d: %s'%len(predicted_d)
print 'g_d: %s'%len(golden_d)

ok_p=0
bad_l=[]
for e in predicted_d:
	if e in golden_d:
		ok_p+=1
	else:
		bad_l.append(e)
print 'ok p: %s'%ok_p
print 'p not in g:: %s'%len(bad_l)

ok_g=0
g_not_in_p=[]
for e in golden_d:
	if e in predicted_d:
		ok_g+=1
	else:
		g_not_in_p.append(e)
print 'ok g: %s'%ok_g
print 'g not in p: %s'%len(g_not_in_p)


for i in range(len(bad_l)):
	bad=predicted_d[bad_l[i]][0]
	bad_name=bad.split('\t')[0].replace('.tab','').replace('rnascfg','')
	print 'p: %s'%bad.replace('.tab','')
	print 'g: %s'%golden_n[bad_name][0]
	print

############

for e in redundant_l:
	print e
	print predicted_d[e]

for e in bad_l:
	print predicted_d[e]
'''
####################
###################
for e in golden_d:
	x=golden_d[e][0][1].split('\t')
	y=predicted_d[e][0].split('\t')
	print '%s\t%s\t%s'%(x[0],y[1],y[2])


