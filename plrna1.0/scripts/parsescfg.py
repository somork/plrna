# parsescfg3.py
# S/ren M/rk
# 04/09/2012

import sys

predicted_in=sys.stdin.read()

p=predicted_in.split('PRISM')[1:]

predicted=[]

for e in p:
	x=[]
	pre_predicted=predicted_in.split('msw')[1:]
	for e in pre_predicted:
		x.append(e.split('\n')[0])
	predicted.append(x)

#print len(predicted)

i=0
for e in predicted:
	#print e
	i+=1
	seq='free'
	stack=[]
	j=0
	for k in e:
		LHS=k.split('(')[2].split(')')[0]	
		RHS=k.split('[')[1].split(']')[0]
		#print LHS
		#print RHS		
		if RHS=='stem,stem':
			seq+='stem'
			stack.append('stem')	
		elif RHS=='free,free':
			seq=seq.replace(LHS,'free')
			stack.append('free')
		elif RHS=='stem,loop':
			st='stem,%s'%str(j)
			j+=1
			if LHS in seq:	
				seq=seq.replace(LHS,st)
			elif '6' in seq:
				seq=seq.replace('6',st)
			elif '5' in seq: 
				seq=seq.replace('5',st)
			elif '4' in seq:
				seq=seq.replace('4',st)
			elif '3' in seq:
				seq=seq.replace('3',st)
			elif '2' in seq:
				seq=seq.replace('2',st)
			elif '1' in seq:
				seq=seq.replace('1',st)
			elif '0' in seq:
				seq=seq.replace('0',st)
		else:
			if LHS in seq:
				seq=seq.replace(LHS,RHS)	
			else:
				if '6' in seq:
					seq=seq.replace('6',RHS)
				elif '5' in seq:
					seq=seq.replace('5',RHS)
				elif '4' in seq:
					seq=seq.replace('4',RHS)
				elif '3' in seq:
					seq=seq.replace('3',RHS)
				elif '2' in seq:
					seq=seq.replace('2',RHS)
				elif '1' in seq:
					seq=seq.replace('1',RHS)
				elif '0' in seq:
					seq=seq.replace('0',RHS)
				else:	
					if len(stack)>0:
						seq+=stack[-1]
						stack=stack[:-1]
						seq=seq.replace(LHS,RHS)

		#print stack
		#print seq

	annot=''
	for s in seq:
		annot+=s
	seq=seq.replace(',','').replace('ar','a').replace('cr','c').replace('gr','g').replace('ur','u').replace('al','a').replace('cl','c').replace('gl','g').replace('ul','u')
	annot=annot.replace(',','').replace('ar',')').replace('cr',')').replace('gr',')').replace('ur',')').replace('al','(').replace('cl','(').replace('gl','(').replace('ul','(').replace('a','.').replace('c','.').replace('g','.').replace('u','.')

	print '%s %s \t%s\t%s'%(i,len(seq),seq.upper(),annot)



	
