#!/bin/sh

seq=$2

count=1

for file in ../../data/fasta/*part.$2.*

do
	#echo $file
	exec &> ../../complexity/$1/$1.$seq.$count
	/usr/bin/time -v RNAfold < $file > ../../decoded/$1/$1.$seq.$count
	count=$((count+1))
done 




