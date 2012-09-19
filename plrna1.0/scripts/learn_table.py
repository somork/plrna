
## e.g. from ../plrna1.0/experiments/rnahmm/rnahmm.canon.50.1.res
## takes a cat file of learn experiments and outputs a table entry: (for each model)

import sys
import math


input=open(sys.argv[1])
data_in=input.read()
input.close()

#model=sys.argv[1].split('/')[3].split('complexity')[0][:-1]

data=data_in.split('Statistics on learning:')[1:]

#######
#Statistics on learning:
#        Graph size: 60302
#        Number of switches: 11
#        Number of switch instances: 32
#        Number of iterations: 11
#        Final log likelihood: -25382.138391884
#        Total learning time: 0.377 seconds
#        Explanation search time: 0.324 seconds
#        Total table space used: 55384616 bytes
#Type show_sw to show the probability distributions.
#####

list=[]
for e in data:
        x=e.split('Type show_sw to show the probability distributions')[0].split('\n')[1:]
#       	print x
       	graph=int(x[0].split(': ')[1])
	nsw=int(x[1].split(': ')[1])
	nswi=int(x[2].split(': ')[1])
	like=float(x[4].split(': ')[1])
	stime=float(x[6].split(': ')[1].split(' ')[0])
	space=int(x[7].split(': ')[1].split(' ')[0])
	list.append((nswi-nsw,stime,graph,like))

# test:
#print len(list)
#print list[0]
#print len(list[0])

d={}
d[0]=[]
d[1]=[]
d[2]=[]
d[3]=[]
d[4]=[]


for i in range(len(list[0])):
	sum=0
	var=0
	num=len(list)
	for e in list:
			sum+=e[i]
	av=sum/num
	for e in list:
		v=(e[i]-av)*(e[i]-av)
		var+=v
	stdev=math.sqrt(var/num)
	d[i].append((av,stdev))

model=sys.argv[1].split('canon')[0]

out_str=model[:-1]
for i in range(len(list[0])):
	#print d[i]
	x=d[i][0][0]
	y=d[i][0][1]
	if type(x)==type(int()):
		w=x
	else:	
		w=round(x,3)
	if type(y)==type(int()):
		z=y
	else:
		z=round(y,3)
	out_str+='&'+str(w)+'$\pm$'+str(z)

print out_str+'\\\\'




