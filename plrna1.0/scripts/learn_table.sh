#!/bin/sh

mkdir tmp

cat ../experiments/rnahmm/rnahmm.canon.50.1.res ../experiments/rnahmm/rnahmm.canon.50.2.res ../experiments/rnahmm/rnahmm.canon.50.3.res ../experiments/rnahmm/rnahmm.canon.50.4.res ../experiments/rnahmm/rnahmm.canon.50.5.res > tmp/rnahmm.canon.cat.res

cat ../experiments/mmrnahmm/mmrnahmm.canon.50.1.res ../experiments/mmrnahmm/mmrnahmm.canon.50.2.res ../experiments/mmrnahmm/mmrnahmm.canon.50.3.res ../experiments/mmrnahmm/mmrnahmm.canon.50.4.res ../experiments/mmrnahmm/mmrnahmm.canon.50.5.res > tmp/mmrnahmm.canon.cat.res

cat ../experiments/mmrnahmm2/mmrnahmm2.canon.50.1.res ../experiments/mmrnahmm2/mmrnahmm2.canon.50.2.res ../experiments/mmrnahmm2/mmrnahmm2.canon.50.3.res ../experiments/mmrnahmm2/mmrnahmm2.canon.50.4.res ../experiments/mmrnahmm2/mmrnahmm2.canon.50.5.res > tmp/mmrnahmm2.canon.cat.res

cat ../experiments/rnascfg/rnascfg.canon.50.1.res ../experiments/rnascfg/rnascfg.canon.50.2.res ../experiments/rnascfg/rnascfg.canon.50.3.res ../experiments/rnascfg/rnascfg.canon.50.4.res ../experiments/rnascfg/rnascfg.canon.50.5.res > tmp/rnascfg.canon.cat.res

cat ../experiments/mmrnascfg/mmrnascfg.canon.50.1.res ../experiments/mmrnascfg/mmrnascfg.canon.50.2.res ../experiments/mmrnascfg/mmrnascfg.canon.50.3.res ../experiments/mmrnascfg/mmrnascfg.canon.50.4.res ../experiments/mmrnascfg/mmrnascfg.canon.50.5.res > tmp/mmrnascfg.canon.cat.res


python ../scripts/learn_table.py tmp/rnahmm.canon.cat.res 
python ../scripts/learn_table.py tmp/mmrnahmm.canon.cat.res 
python ../scripts/learn_table.py tmp/mmrnahmm2.canon.cat.res 
python ../scripts/learn_table.py tmp/rnascfg.canon.cat.res 
python ../scripts/learn_table.py tmp/mmrnascfg.canon.cat.res 







