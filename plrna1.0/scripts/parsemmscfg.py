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
	jl=0
	jrb=0
	jlb=0
	for k in e:
		LHS=k.split('(')[2].split(',')[0]	
		RHS=k.split('[')[1].split(']')[0]
		#print LHS
		#print RHS
		#print jrb		
		if RHS=='stem,stem':
			seq+='stem'
			stack.append('stem')	
		elif RHS=='free,free':
			seq=seq.replace(LHS,'free')
			stack.append('free')
		elif RHS=='stem,loop':
			st='stem,l%s'%str(jl)
			jl+=1
			if LHS in seq:	
				seq=seq.replace(LHS,st)
			elif 'l6' in seq:
				seq=seq.replace('l6',st)
			elif 'l5' in seq: 
				seq=seq.replace('l5',st)
			elif 'l4' in seq:
				seq=seq.replace('l4',st)
			elif 'l3' in seq:
				seq=seq.replace('l3',st)
			elif 'l2' in seq:
				seq=seq.replace('l2',st)
			elif 'l1' in seq:
				seq=seq.replace('l1',st)
			elif 'l0' in seq:
				seq=seq.replace('l0',st)
		elif 'rb' in RHS:
			#rep='r%s'%str(jrb)
			#st=RHS.replace('rb',rep)
			#jrb+=1
			#if LHS in seq:
			#	seq=seq.replace(LHS,RHS)
			#if 'r1' in seq:
			#	#jrb+=1
			#	rep='r%s'%str(jrb)
                        #	st=RHS.replace('rb',rep)
			#	if LHS in seq:
			#		seq=seq.replace(LHS,st)
			#	else:
			#		seq=seq.replace('r1',LHS)

			if LHS in seq:	
				#jbr=0
				rep='r%s'%str(jrb)
                        	st=RHS.replace('rb',rep)
				seq=seq.replace(LHS,st)
				jrb+=1
			elif 'r2' in seq: 
				#if len(RHS)==1:
				#	seq=seq.replace('r2',RHS)
				if 'stem,rb' in RHS:
					jrb+=1
					rep='r%s'%str(jrb)
                        		st=RHS.replace('rb',rep)
					seq=seq.replace(LHS,st)
				else:
					if 'rb' in RHS:
						seq=seq.replace('r2',RHS.replace('rb','r2'))
					#else:
					#	seq=seq.replace('r2',RHS)
			elif 'r1' in seq: 
				#if len(RHS)==1:
				#	seq=seq.replace('r1',RHS)
				#	print RHS
				if 'stem,rb' in RHS:
					jrb+=1
					rep='r%s'%str(jrb)
                        		st=RHS.replace('rb',rep)
					seq=seq.replace(LHS,st)
				elif 'rb' in RHS:
					seq=seq.replace('r1',RHS.replace('rb','r1'))
				#else:
				#	print 'Hey!!'
				#	seq=seq.replace('r1','')
			elif 'r0' in seq: 
				#if len(RHS)==1:
				#	seq=seq.replace('r0',RHS)
				if 'stem,rb' in RHS:
					jrb+=1
					rep='r%s'%str(jrb)
                        		st=RHS.replace('rb',rep)
					seq=seq.replace(LHS,st)
				elif 'rb' in RHS:
					seq=seq.replace('r0',RHS.replace('rb','r0'))
		elif LHS=='rb':
			if len(RHS)==1:
				if 'r2' in seq:
					seq=seq.replace('r2',RHS)	
				elif 'r1' in seq:
					seq=seq.replace('r1',RHS)	
				elif 'r0' in seq:
					seq=seq.replace('r0',RHS)	

		elif 'lb' in RHS:
			rep='b%s'%str(jlb)
			st=RHS.replace('lb',rep)
			jlb+=1
			if LHS in seq:	
				seq=seq.replace(LHS,st)
			elif 'b6' in seq:
				seq=seq.replace('b6',st)
			elif 'b5' in seq: 
				seq=seq.replace('b5',st)
			elif 'b4' in seq:
				seq=seq.replace('b4',st)
			elif 'b3' in seq:
				seq=seq.replace('b3',st)
			elif 'b2' in seq:
				seq=seq.replace('b2',st)
			elif 'b1' in seq:
				seq=seq.replace('b1',st)
			elif 'b0' in seq:
				seq=seq.replace('b0',st)
		else:
			if LHS in seq:
				seq=seq.replace(LHS,RHS)	
			else:
				if 'l6' in seq:
					seq=seq.replace('l6',RHS)
				elif 'l5' in seq:
					seq=seq.replace('l5',RHS)
				elif 'l4' in seq:
					seq=seq.replace('l4',RHS)
				elif 'l3' in seq:
					seq=seq.replace('l3',RHS)
				elif 'l2' in seq:
					seq=seq.replace('l2',RHS)
				elif 'l1' in seq:
					seq=seq.replace('l1',RHS)
				elif 'l0' in seq:
					seq=seq.replace('l0',RHS)
				else:	
					if len(stack)>0:
						seq+=','+stack[-1]
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



	