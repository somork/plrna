#!/bin/sh

sed s/part.not.x/part.not.$2/g ../../models/$1.psm > $1.psm

~/prism/21/bin/prism -g "[autoAnnotations],prismAnnot($1,direct),learn,save_sw,halt" > $1.canon.50.$2.res


