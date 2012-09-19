#!/bin/sh


cat rnahmm/rnahmm.* > cats/rnahmm.complexity
cat mmrnahmm/mmrnahmm.* > cats/mmrnahmm.complexity
cat mmrnahmm2/mmrnahmm2.* > cats/mmrnahmm2.complexity
cat rnascfg/rnascfg.* > cats/rnascfg.complexity
cat mmrnascfg/mmrnascfg.* > cats/mmrnascfg.complexity
cat rnafold/rnafold.* > cats/rnafold.complexity

cat random/rnahmm/rnahmm.* > cats/rnahmm.complexity.rand
cat random/mmrnahmm/mmrnahmm.* > cats/mmrnahmm.complexity.rand
cat random/mmrnahmm2/mmrnahmm2.* > cats/mmrnahmm2.complexity.rand
cat random/rnascfg/rnascfg.* > cats/rnascfg.complexity.rand
cat random/mmrnascfg/mmrnascfg.* > cats/mmrnascfg.complexity.rand
cat random/rnafold/rnafold.* > cats/rnafold.complexity.rand


###### change complexity_table to take aconcat of the above and the lens and output a table!

#########################
cat ../data/fasta/random* > ../data/random_seqs.cat
cat ../data/fasta/rfam95.* > ../data/fasta_seqs.cat

cat ../data/random_seqs.cat | python ../scripts/random_len.py > ../stats/random_seqs.len
cat ../data/fasta_seqs.cat | python ../scripts/fasta_len.py > ../stats/fasta_seqs.len


cat ../complexity/cats/rnahmm.complexity | python ../scripts/complexity_numbers.py time > ../stats/rnahmm.complexity.time
cat ../complexity/cats/rnahmm.complexity | python ../scripts/complexity_numbers.py memory > ../stats/rnahmm.complexity.memory

cat ../complexity/cats/mmrnahmm.complexity | python ../scripts/complexity_numbers.py time > ../stats/mmrnahmm.complexity.time
cat ../complexity/cats/mmrnahmm.complexity | python ../scripts/complexity_numbers.py memory > ../stats/mmrnahmm.complexity.memory

cat ../complexity/cats/mmrnahmm2.complexity | python ../scripts/complexity_numbers.py time > ../stats/mmrnahmm2.complexity.time
cat ../complexity/cats/mmrnahmm2.complexity | python ../scripts/complexity_numbers.py memory > ../stats/mmrnahmm2.complexity.memory

cat ../complexity/cats/rnascfg.complexity | python ../scripts/complexity_numbers.py time > ../stats/rnascfg.complexity.time
cat ../complexity/cats/rnascfg.complexity | python ../scripts/complexity_numbers.py memory > ../stats/rnascfg.complexity.memory

cat ../complexity/cats/mmrnascfg.complexity | python ../scripts/complexity_numbers.py time > ../stats/mmrnascfg.complexity.time
cat ../complexity/cats/mmrnascfg.complexity | python ../scripts/complexity_numbers.py memory > ../stats/mmrnascfg.complexity.memory

cat ../complexity/cats/rnafold.complexity | python ../scripts/complexity_numbers.py time > ../stats/rnafold.complexity.time
cat ../complexity/cats/rnafold.complexity | python ../scripts/complexity_numbers.py memory > ../stats/rnafold.complexity.memory


cat ../complexity/cats/rnahmm.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/rnahmm.complexity.rand.time
cat ../complexity/cats/rnahmm.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/rnahmm.complexity.rand.memory

cat ../complexity/cats/mmrnahmm.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/mmrnahmm.complexity.rand.time
cat ../complexity/cats/mmrnahmm.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/mmrnahmm.complexity.rand.memory

cat ../complexity/cats/mmrnahmm2.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/mmrnahmm2.complexity.rand.time
cat ../complexity/cats/mmrnahmm2.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/mmrnahmm2.complexity.rand.memory

cat ../complexity/cats/rnascfg.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/rnascfg.complexity.rand.time
cat ../complexity/cats/rnascfg.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/rnascfg.complexity.rand.memory

cat ../complexity/cats/mmrnascfg.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/mmrnascfg.complexity.rand.time
cat ../complexity/cats/mmrnascfg.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/mmrnascfg.complexity.rand.memory

cat ../complexity/cats/rnafold.complexity.rand | python ../scripts/complexity_numbers.py time > ../stats/rnafold.complexity.rand.time
cat ../complexity/cats/rnafold.complexity.rand | python ../scripts/complexity_numbers.py memory > ../stats/rnafold.complexity.rand.memory




