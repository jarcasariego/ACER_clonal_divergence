#!/bin/bash

# Script takes the CpG bed files generated from methyKit work up of the Cyto_summary outputs from bismark and
# intersect them with the major genomic features (genes, exons,introns, intergenic,mRNA) using genome tracks generated
# by Yaamini. It does this for all CpGs, those with at least 5x coverage, and those that were diff. mehtylated by trt
# among both timepoints, and then for each timepoint separately.

## Setting variable paths

# Date used when auto generating your file outputs
# Output Path
path="/scratch/jeirinlo/jrodr979/DML_analysis/20210119_FeatureCpGDist/"
# Date header on each file
saveDate="20210119"
# Path to where the bed files are located
CpGPath="/scratch/jeirinlo/jrodr979/DML_analysis/20210119_FeatureCpGDist/bed_files/all.colonies/"
# Path to the genome track files
featurePath="/scratch/jeirinlo/jrodr979/2021-01-08-Mcav_Genomic-feature-track_corrected/"

# Differentially methylated loci lists (as .bed files)
CpGall="${CpGPath}CpG_allCpGs.bed"
CpGcov5="${CpGPath}CpG_5xCov.bed"
DMLCcDc="${CpGPath}DML_Cc_Dc_dM25_q01ChiSq_overDispCorrected_allSig.bed"
DMLCcCh="${CpGPath}DML_Cc_Ch_dM25_q01ChiSq_overDispCorrected_allSig.bed"
DMLChDh="${CpGPath}DML_Ch_Dh_dM25_q01ChiSq_overDispCorrected_allSig.bed"
DMLDcDh="${CpGPath}DML_Dc_Dh_dM25_q01ChiSq_overDispCorrected_allSig.bed" 
# Hyper vs. Hypo
DMLCcDchyper="${CpGPath}DML_Cc_Dc_dM25_q01ChiSq_overDispCorrected_hyper.bed"
DMLCcDchypo="${CpGPath}DML_Cc_Dc_dM25_q01ChiSq_overDispCorrected_hypo.bed"
DMLCcChhyper="${CpGPath}DML_Cc_Ch_dM25_q01ChiSq_overDispCorrected_hyper.bed"
DMLCcChhypo="${CpGPath}DML_Cc_Ch_dM25_q01ChiSq_overDispCorrected_hypo.bed"
DMLChDhhyper="${CpGPath}DML_Ch_Dh_dM25_q01ChiSq_overDispCorrected_hyper.bed"
DMLChDhhypo="${CpGPath}DML_Ch_Dh_dM25_q01ChiSq_overDispCorrected_hypo.bed"
DMLDcDhhyper="${CpGPath}DML_Dc_Dh_dM25_q01ChiSq_overDispCorrected_hyper.bed"
DMLDcDhhypo="${CpGPath}DML_Dc_Dh_dM25_q01ChiSq_overDispCorrected_hypo.bed"
# Feature lists (as .bed files)
geneGFF="${featurePath}Mcav.GFFannotation.gene.gff"
exonL="${featurePath}Mcav.GFFannotation.exon_sorted_jarc.bed "
intronL="${featurePath}Mcav.GFFannotation.intron_final_jarc.bed"
geneL="${featurePath}Mcav.GFFannotation.gene_sorted_jarc.bed"
interL="${featurePath}Mcav.GFFannotation.intergenic_final_jarc.bed"
mRNAL="${featurePath}Mcav.GFFannotation.mRNA_jarc.bed"
repeatL="${featurePath}Mcav.TE_all_jarc.bed"

#### Overlap of exons with genes ####
echo "Identifying ${exonL} in ${geneL} ..." 
echo "Identifying ${exonL} in ${geneL} ..." > ${path}${saveDate}_overlappingSummary.txt
# Exons in Genes
bedtools intersect \
-wa -wb \
-a ${geneL} \
-b ${exonL} \
> ${path}${saveDate}_exonInGeneSummary.txt
exonInGene="${path}${saveDate}_exonInGeneSummary.txt"

# Annotate
bedtools intersect \
-wa -wb \
-a ${exonInGene} \
-b ${geneGFF} \
> ${path}${saveDate}_exonInGeneSummary_annotated.txt

#### Examine how the CpGs overlap with different features ####
echo "Identifying CpGs in ${CpGcov5} ..." 
echo "Identifying CpGs in ${CpGcov5} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${exonL} \
> ${path}${saveDate}_CpG_cov5_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${intronL} \
> ${path}${saveDate}_CpG_cov5_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${geneL} \
> ${path}${saveDate}_CpG_cov5_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${interL} \
> ${path}${saveDate}_CpG_cov5_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${mRNAL} \
> ${path}${saveDate}_CpG_cov5_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${CpGcov5} \
-a ${repeatL} \
> ${path}${saveDate}_CpG_cov5_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt



## Examine how the CpGs overlap with different features
echo "Identifying all CpGs in ${CpGall} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons 
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${exonL} \
> ${path}${saveDate}_CpG_all_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${intronL} \
> ${path}${saveDate}_CpG_all_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${geneL} \
> ${path}${saveDate}_CpG_all_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${interL} \
> ${path}${saveDate}_CpG_all_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${mRNAL} \
> ${path}${saveDate}_CpG_all_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${CpGall} \
-a ${repeatL} \
> ${path}${saveDate}_CpG_all_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt

## Examine how the DMLs (DML_Cc.Dc) for treatment overlap with different features
echo "Identifying all CpGs in ${DMLCcDc} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons 
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${exonL} \
> ${path}${saveDate}_DML_Cc.Dc_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${intronL} \
> ${path}${saveDate}_DML_Cc.Dc_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${geneL} \
> ${path}${saveDate}_DML_Cc.Dc_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${interL} \
> ${path}${saveDate}_DML_Cc.Dc_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${mRNAL} \
> ${path}${saveDate}_DML_Cc.Dc_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${DMLCcDc} \
-a ${repeatL} \
> ${path}${saveDate}_DML_Cc.Dc_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt

## Examine how the DMLs (DML_Cc.Ch) for treatment overlap with different features
echo "Identifying all CpGs in ${DMLCcCh} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons 
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${exonL} \
> ${path}${saveDate}_DML_Cc.Ch_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${intronL} \
> ${path}${saveDate}_DML_Cc.Ch_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${geneL} \
> ${path}${saveDate}_DML_Cc.Ch_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${interL} \
> ${path}${saveDate}_DML_Cc.Ch_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${mRNAL} \
> ${path}${saveDate}_DML_Cc.Ch_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${DMLCcCh} \
-a ${repeatL} \
> ${path}${saveDate}_DML_Cc.Ch_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt

## Examine how the DMLs (DML_Ch.Dh) for treatment overlap with different features
echo "Identifying all CpGs in ${DMLChDh} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons 
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${exonL} \
> ${path}${saveDate}_DML_Ch.Dh_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${intronL} \
> ${path}${saveDate}_DML_Ch.Dh_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${geneL} \
> ${path}${saveDate}_DML_Ch.Dh_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${interL} \
> ${path}${saveDate}_DML_Ch.Dh_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${mRNAL} \
> ${path}${saveDate}_DML_Ch.Dh_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${DMLChDh} \
-a ${repeatL} \
> ${path}${saveDate}_DML_Ch.Dh_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt

## Examine how the DMLs (DML_Dc.Dh) for treatment overlap with different features
echo "Identifying all CpGs in ${DMLDcDh} ..." >> ${path}${saveDate}_overlappingSummary.txt
# Exons 
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${exonL} \
> ${path}${saveDate}_DML_Dc.Dh_Exon.txt
echo "that overlap with ${exonL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Introns
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${intronL} \
> ${path}${saveDate}_DML_Dc.Dh_Intron.txt
echo "that overlap with ${intronL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Genes
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${geneL} \
> ${path}${saveDate}_DML_Dc.Dh_gene.txt
echo "that overlap with ${geneL}..." >> ${path}${saveDate}_overlappingSummary.txt

# Intergenic
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${interL} \
> ${path}${saveDate}_DML_Dc.Dh_Intergenic.txt
echo "that overlap with ${interL}..." >> ${path}${saveDate}_overlappingSummary.txt

# mRNA
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${mRNAL} \
> ${path}${saveDate}_DML_Dc.Dh_mRNA.txt
echo "that overlap with ${mRNAL}..." >> ${path}${saveDate}_overlappingSummary.txt

# put.transposable elements
bedtools intersect \
-wa -wb \
-b ${DMLDcDh} \
-a ${repeatL} \
> ${path}${saveDate}_DML_Dc.Dh_repeatL.txt
echo "that overlap with ${repeatL}..." >> ${path}${saveDate}_overlappingSummary.txt
