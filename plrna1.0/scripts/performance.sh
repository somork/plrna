#!/bin/sh

#from ../scripts do:

./structureCC -f=../tabs/$1/$1.canon.50.part.all.tab.named ../raw_data/rfam95.90.30.canon.50.tab.part.all > ../tabs/$1/$1.canon.50.mcc

cat ../tabs/$1/$1.canon.50.mcc | python mcc_av_clust.py > ../tabs/$1/$1.canon.50.mcc.av.clust 

cat ../tabs/$1/$1.canon.50.mcc.av.clust | python tab2table.py > ../tables/$1.canon.50.mcc.av.clust.table 



