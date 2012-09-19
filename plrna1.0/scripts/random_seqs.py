# random_seq2.py
# S/ren M/rk
# 15/6/12


import random
import sys

antal=int(sys.argv[1])
leng=int(sys.argv[2])

nc=['a','c','g','u']

for j in range(antal):
        seq=''
        for i in range(leng):
	        nc_sample=random.sample(nc,1)[0]
	        seq+=','+nc_sample
        print '[%s]'%seq[1:]



