#!/bin/bash

### Dataset

multiIntersectBed -i \
N11_D_10x.tab \
N11_S_10x.tab \
N12_D_10x.tab \
N12_S_10x.tab \ 
N35_D_10x.tab \
N35_S_10x.tab \
N36_D_10x.tab \
N36_S_10x.tab \
N43_D_10x.tab \
N43_S_10x.tab \
N45_D_10x.tab \
N45_S_10x.tab \
N66_D_10x.tab \
N66_S_10x.tab \
N68_D_10x.tab \
N68_S_10x.tab \
N85_D_10x.tab \
N85_S_10x.tab \
N86_D_10x.tab \
N86_S_10x.tab \
N90_D_10x.tab \
N90_S_10x.tab \
V41_D_10x.tab \
V41_S_10x.tab \
V57_D_10x.tab \
V57_S_10x.tab \
> merged.10x.bed

cat merged.10x.bed | awk '$4 ==26' > merged.filtered.26.10x.bed
 
#Use intersectBed to find where loci and genes intersect, allowing loci to be mapped to annotated genes
#wb: Print all lines in the second file
#a: file that ends in posOnly
#b: annotated gene list
#Save output in a new file that has the same base name and ends in -Annotated.txt

for f in *10x.tab
do
  intersectBed \
  -wb \
  -a ${f} \
  -b ../../20220715_Genome_transcriptome_corr/Acer_trans2genome_coor.t
ab
  > ${f}_gene
done

#intersect with previous merged file to subset only those positions found in all samples
for f in *_gene
do
  intersectBed \
  -a ${f} \
  -b merged.filtered.26.10x.bed  \
  > ${f}_CpG_shared.bed
done
wc -l *_CpG_shared.bed
