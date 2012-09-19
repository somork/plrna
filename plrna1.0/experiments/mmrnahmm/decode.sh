#!/bin/sh

seq=$2

count=1

cp ./Saved_SW ./$1_canon_50_$2_sw

while read line

do
	exec &> ../../complexity/$1/$1.$seq.$count
	/usr/bin/time -v ~/prism/21/bin/prism -g "[autoAnnotations],prismAnnot($1),restore_sw,S=$line,viterbiAnnot(model(S,DotBracket),P),writeln(S),writeln(DotBracket),halt" > ../../decoded/$1/$1.$seq.$count
	count=$((count+1))
done 


