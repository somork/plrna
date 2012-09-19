# tab2lim.py
# S/ren M/rk
# 15/06/2012

import sys

data_in=sys.stdin.read()

data=data_in.split('\n')[:-1]

mode=sys.argv[1]

lim=int(sys.argv[2])

if mode=='len':
	for e in data:
		x=e.split('\t')
		if len(x[2])>lim:
			bad=0
		else:
			print e
if mode=='min':
	for e in data:
		x=e.split('\t')
		if len(x[2])<lim:
			bad=0
		else:
			print e
	
if mode=='stack':
	for e in data:
		x=e.split('\t')
		i=0
		max=0
		for k in x[2]:
			if i>max:
				max=i
			if k=='(':
				i+=1
			elif k==')':
				i-=1
		if max>lim:
			bad=0
		else:
			print e			

singles=['A','C','G','U']
pairs=['AU','CG','GC','UA','GU','UG']

outlist=[]

if mode=='canonical':
	#print 'hello!'
	for e in data:
		bad=0
		x=e.split('\t')
		if '()' in x[2]:
			bad=1
		elif '(.)' in x[2]:
			bad=1
		elif '(..)' in x[2]:
			bad=1
		elif 'Predicted' in e:
			bad=1
		stack=[]
		i=0
		#while i >len(x[2]):
		for i in range(len(x[2])):
			y=x[1][i]
			z=x[2][i]
			if y in singles:
				if z=='(':
					stack.append(y)
				elif z==')':
					w=stack[-1]
					stack=stack[:-1]
					if y+w in pairs:
						yes=0
					else:
						#print y+w
						bad=1
			else:
				#print y
				bad=1
		if bad==0:
			l=len(x[2])
			if l<lim+1:
				outlist.append((l,e))
		#else:
			#print 'HEEEloo!'
	outlist.sort()
	for k in outlist:
		print k[1]	

