#!/bin/sh

sed s/part.not.x/part.not.$2/g ../../models/$1_annot.psm > $1_annot.psm

~/prism/21/bin/prism -g "prism($1_annot),learn,save_sw." > $1.canon.50.$2.res


