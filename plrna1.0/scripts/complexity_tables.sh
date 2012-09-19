#!/bin/sh


python ../scripts/complexity_table.py ../complexity/cats/rnahmm.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/1.tmp

python ../scripts/complexity_table.py ../complexity/cats/mmrnahmm.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/2.tmp

python ../scripts/complexity_table.py ../complexity/cats/mmrnahmm2.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/3.tmp

python ../scripts/complexity_table.py ../complexity/cats/rnascfg.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/4.tmp

python ../scripts/complexity_table.py ../complexity/cats/mmrnascfg.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/5.tmp

python ../scripts/complexity_table.py ../complexity/cats/rnafold.complexity.rand ../data/random_seqs.cat > ../complexity/tmp/6.tmp

cat tmp/1.tmp tmp/2.tmp tmp/3.tmp tmp/4.tmp tmp/5.tmp tmp/6.tmp > tmp/cat.tmp

python ../scripts/complexity_table2.py tmp/cat.tmp > ../tables/complexity.table







