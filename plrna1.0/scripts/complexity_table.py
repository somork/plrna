import sys
import math


input=open(sys.argv[1])
data_in=input.read()
input.close()

input=open(sys.argv[2])
names_in=input.read()
input.close()

model=sys.argv[1].split('/')[3].split('complexity')[0][:-1]

names=names_in.split('\n')[1:]

data=data_in.split('User time (seconds): ')[1:]

list=[]
for e in data:
        x=e.split('Average resident set size (kbytes): 0')[0].split('\n')       
        z= x[0]
        y=x[-2].split('Maximum resident set size (kbytes): ')[1]
        list.append((float(z),float(y)))

d={}
d_k=[]
for i in range(len(names)):
	x=len(names[i].split('[')[1].split(']')[0])
	if x in d:
		d[x].append(list[i]) 
	else:
		d[x]=[list[i]]
		d_k.append(x)

# test:
#print 'names: %s'%len(names)
#print 'data: %s'%len(data)
#print names[0]
#print names[-1]
#print list[0]
#print list[-1]
#print d_k

######### average complexity:
out_str_t=model
out_str_m=model
for e in d_k:
	sum_t=0
	sum_m=0
	var_t=0
	var_m=0
	m=d[e]	
	num=len(m)
	for k in m:
		sum_t+=k[0]
		sum_m+=k[1]
	av_t=sum_t/num
	av_m=sum_m/num		
	for k in m:
		v_t=(k[0]-av_t)*(k[0]-av_t)
		var_t+=v_t
		v_m=(k[1]-av_m)*(k[1]-av_m)
		var_m+=v_m
	stdev_t=math.sqrt(var_t/num)
	stdev_m=math.sqrt(var_m/num)
	out_str_t+='&'+'%s\pm%s'%(av_t,round(stdev_t,3))
	out_str_m+='&'+'%s\pm%s'%(int(round(av_m)),int(round(stdev_m)))

print out_str_t
print out_str_m

