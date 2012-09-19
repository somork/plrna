#!/bin/sh

seq=$2

count=1

for file in ../../data/fasta/*random*

do
	exec &> ../../complexity/random/$1/$1.$seq.$count
	/usr/bin/time -v RNAfold < $file > ../../decoded/$1/$1.$seq.$count
	count=$((count+1))
done 




