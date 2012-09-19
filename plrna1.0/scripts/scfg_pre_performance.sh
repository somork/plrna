#!/bin/sh


cat $1.canon.50.1.dec | python ../../scripts/dec2tab_scfg.py $1.canon.50.1.names > $1.canon.50.1.tab
cat $1.canon.50.2.dec | python ../../scripts/dec2tab_scfg.py $1.canon.50.2.names > $1.canon.50.2.tab
cat $1.canon.50.3.dec | python ../../scripts/dec2tab_scfg.py $1.canon.50.3.names > $1.canon.50.3.tab
cat $1.canon.50.4.dec | python ../../scripts/dec2tab_scfg.py $1.canon.50.4.names > $1.canon.50.4.tab
cat $1.canon.50.5.dec | python ../../scripts/dec2tab_scfg.py $1.canon.50.5.names > $1.canon.50.5.tab

cat $1.canon.50.1.tab $1.canon.50.2.tab $1.canon.50.3.tab $1.canon.50.4.tab $1.canon.50.5.tab > $1.canon.50.all.tab

cat $1.canon.50.all.tab | python ../../scripts/namepred.py ../../raw_data/rfam95.90.30.canon.50.tab.part.all > $1.canon.50.part.all.tab.named


