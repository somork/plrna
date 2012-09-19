#!/bin/sh

cat rfam95.90.30.tab | python ../scripts/tab2lim.py canonical 50 > rfam95.90.30.canon.50.tab
cat rfam95.90.30.tab | python ../scripts/tab2lim.py canonical 100 > rfam95.90.30.canon.100.tab
cat rfam95.90.30.tab | python ../scripts/tab2lim.py canonical 500 > rfam95.90.30.canon.500.tab
cat rfam95.90.30.tab | python ../scripts/tab2lim.py canonical 5000 > rfam95.90.30.canon.5000.tab

python ../scripts/tab2xval_fam.py rfam95.90.30.canon.50.tab 5

cat rfam95.90.30.tab | python ../scripts/tab2lens.py > ../stats/rfam95.90.30.lens


