import sys

lst_in=sys.stdin.read()

lst=lst_in.split('\n')[1:]

for e in lst:
	print len(e)

