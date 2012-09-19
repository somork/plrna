#!/bin/sh

cat rfam95.90.30.canon.50.tab.part.1 | python ../scripts/tab2lst.py > ../data/rfam95.90.30.canon.50.tab.part.1.lst
cat rfam95.90.30.canon.50.tab.part.2 | python ../scripts/tab2lst.py > ../data/rfam95.90.30.canon.50.tab.part.2.lst
cat rfam95.90.30.canon.50.tab.part.3 | python ../scripts/tab2lst.py > ../data/rfam95.90.30.canon.50.tab.part.3.lst
cat rfam95.90.30.canon.50.tab.part.4 | python ../scripts/tab2lst.py > ../data/rfam95.90.30.canon.50.tab.part.4.lst
cat rfam95.90.30.canon.50.tab.part.5 | python ../scripts/tab2lst.py > ../data/rfam95.90.30.canon.50.tab.part.5.lst

#cat rfam95.90.30.canon.50.tab.part.1 | python ../scripts/tab2fasta.py > ../data/rfam95.90.30.canon.50.tab.part.1.fasta
#cat rfam95.90.30.canon.50.tab.part.2 | python ../scripts/tab2fasta.py > ../data/rfam95.90.30.canon.50.tab.part.2.fasta
#cat rfam95.90.30.canon.50.tab.part.3 | python ../scripts/tab2fasta.py > ../data/rfam95.90.30.canon.50.tab.part.3.fasta
#cat rfam95.90.30.canon.50.tab.part.4 | python ../scripts/tab2fasta.py > ../data/rfam95.90.30.canon.50.tab.part.4.fasta
#cat rfam95.90.30.canon.50.tab.part.5 | python ../scripts/tab2fasta.py > ../data/rfam95.90.30.canon.50.tab.part.5.fasta

#cat rfam95.90.30.canon.50.tab.part.1 | python ../scripts/tab2fast.py > ../data/rfam95.90.30.canon.50.tab.part.1.fast
#cat rfam95.90.30.canon.50.tab.part.2 | python ../scripts/tab2fast.py > ../data/rfam95.90.30.canon.50.tab.part.2.fast
#cat rfam95.90.30.canon.50.tab.part.3 | python ../scripts/tab2fast.py > ../data/rfam95.90.30.canon.50.tab.part.3.fast
#cat rfam95.90.30.canon.50.tab.part.4 | python ../scripts/tab2fast.py > ../data/rfam95.90.30.canon.50.tab.part.4.fast
#cat rfam95.90.30.canon.50.tab.part.5 | python ../scripts/tab2fast.py > ../data/rfam95.90.30.canon.50.tab.part.5.fast


python ../scripts/tab2fast.py rfam95.90.30.canon.50.tab.part.1 
python ../scripts/tab2fast.py rfam95.90.30.canon.50.tab.part.2 
python ../scripts/tab2fast.py rfam95.90.30.canon.50.tab.part.3 
python ../scripts/tab2fast.py rfam95.90.30.canon.50.tab.part.4 
python ../scripts/tab2fast.py rfam95.90.30.canon.50.tab.part.5 


### x-val training sets:
cat rfam95.90.30.canon.50.tab.part.2 rfam95.90.30.canon.50.tab.part.3 rfam95.90.30.canon.50.tab.part.4 rfam95.90.30.canon.50.tab.part.5 > rfam95.90.30.canon.50.tab.part.not.1

cat rfam95.90.30.canon.50.tab.part.1 rfam95.90.30.canon.50.tab.part.3 rfam95.90.30.canon.50.tab.part.4 rfam95.90.30.canon.50.tab.part.5 > rfam95.90.30.canon.50.tab.part.not.2

cat rfam95.90.30.canon.50.tab.part.1 rfam95.90.30.canon.50.tab.part.2 rfam95.90.30.canon.50.tab.part.4 rfam95.90.30.canon.50.tab.part.5 > rfam95.90.30.canon.50.tab.part.not.3

cat rfam95.90.30.canon.50.tab.part.1 rfam95.90.30.canon.50.tab.part.2 rfam95.90.30.canon.50.tab.part.3 rfam95.90.30.canon.50.tab.part.5 > rfam95.90.30.canon.50.tab.part.not.4

cat rfam95.90.30.canon.50.tab.part.1 rfam95.90.30.canon.50.tab.part.2 rfam95.90.30.canon.50.tab.part.3 rfam95.90.30.canon.50.tab.part.4 > rfam95.90.30.canon.50.tab.part.not.5

cat rfam95.90.30.canon.50.tab.part.not.5 rfam95.90.30.canon.50.tab.part.5 > rfam95.90.30.canon.50.tab.part.all


