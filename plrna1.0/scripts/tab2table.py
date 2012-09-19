import sys

lst_in=sys.stdin.read()

lst=lst_in.split('\n')[:-1]

for e in lst:	
	x=e.split('\t')
	ostr=x[0]
	for k in x[1:]:
		ostr+='&'+k
	ostr+='\\\\'
	print ostr

