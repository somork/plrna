#!/bin/sh

for e in *

do
	cat $e | python ../../scripts/parsescfg2.py > ../../decs/rnascfg/$e.tab
done



