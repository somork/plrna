# tab2stats.py
# S/ren M/rk
# 18/06/2012

###################
# modes: len, stack, loop,bifurc,mbifurc,lbulge,rbulge,left,right 
###################

import sys
import re

data=sys.stdin.readlines()

#data=data_in.split('\n')[:-1]

mode=sys.argv[1]

print data

if mode=='len':
	for e in data:
		print len(e.split(' ')[1])
	
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
		print max			


loop_p=re.compile('\(\.+\)')

lbulge_p=re.compile('\(\.+\(')
rbulge_p=re.compile('\)\.+\)')
bifurc_p=re.compile('\)\.*\(')

left_p=re.compile('\(+')
right_p=re.compile('\)+')

lstem_p=re.compile('\([\(\.]+\(')
rstem_p=re.compile('\)[\)\.]+\)')

if mode=='lstem':
	lstems=[]
	for e in data:
		x=e.split('\t')	
		for k in lstem_p.findall(x[2]):
			lstems.append(len(k)-2)			
	for e in lstems:
		print e

if mode=='rstem':
	rstems=[]
	for e in data:
		x=e.split('\t')	
		for k in rstem_p.findall(x[2]):
			rstems.append(len(k)-2)			
	for e in rstems:
		print e


if mode=='loop':
	loops=[]
	for e in data:
		x=e.split('\t')	
		for k in loop_p.findall(x[2]):
			loops.append(len(k)-2)			
	for e in loops:
		print e



if mode=='bifurc':
	bifurcs=[]
	for e in data:
		x=e.split('\t')	
		for k in bifurc_p.findall(x[2]):
			bifurcs.append(len(k)-2)			
	for e in bifurcs:
		print e

if mode=='mbifurc':
	max_bifurcs=[]
	for e in data:
		x=e.split('\t')	
		#for k in bifurc_p.findall(x[2]):
		max_bifurcs.append(len(bifurc_p.findall(x[2])))			
	for e in max_bifurcs:
		print e

if mode=='lbulge':
	lbulges=[]
	for e in data:
		x=e.split('\t')	
		for k in lbulge_p.findall(x[2]):
			lbulges.append(len(k)-2)			
	for e in lbulges:
		print e

if mode=='rbulge':
	rbulges=[]
	for e in data:
		x=e.split('\t')	
		for k in rbulge_p.findall(x[2]):
			rbulges.append(len(k)-2)			
	for e in rbulges:
		print e

if mode=='left':
	lefts=[]
	for e in data:
		x=e.split('\t')	
		for k in left_p.findall(x[2]):
			lefts.append(len(k)-2)			
	for e in lefts:
		print e

if mode=='right':
	rights=[]
	for e in data:
		x=e.split('\t')	
		for k in right_p.findall(x[2]):
			rights.append(len(k)-2)			
	for e in rights:
		print e


