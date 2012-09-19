#!/bin/sh

for e in *

do
	cat $e | python ../../scripts/parsemmscfg2.py > ../../decs/mmrnascfg/$e.tab
done



