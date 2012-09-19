import sys
import math

lst_in=sys.stdin.read()

mode=sys.argv[1]


#print lst_in

lst=lst_in.split('User time (seconds): ')[1:]

list=[]

for e in lst:
        x=e.split('Average resident set size (kbytes): 0')[0].split('\n')       
        z=x[0]
        y=x[-2].split('Maximum resident set size (kbytes): ')[1]
	if mode=='time':
		print z
	if mode=='memory':
		print int(y)/4        




