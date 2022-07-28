#!/bin/bash

#determine annotation types and display counts

grep -v '^#' /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy1-\[Acerv_assembly_v1.0.gff3\].gff3 | cut -s -f 3 | sort | uniq -c | sort -rn > all_features.txt

#extract feature types and generate individual gff
### Note that the annotation contains two methods EVM and tRNAScan-SE. These need to be separated because the tRNA also contains exon and gene tracks. 

grep $'\ttRNAScan-SE\t' /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy1-\[Acerv_assembly_v1.0.gff3\].gff3 > tRNA_Scan_Annotation_ACER.gff3
grep $'\tEVM\t' /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy1-\[Acerv_assembly_v1.0.gff3\].gff3 > EVM_Annotation_ACER.gff3

grep $'\tmRNA\t' EVM_Annotation_ACER.gff3 > Acer.GFFannotation.mRNA.gff
grep $'\tgene\t' EVM_Annotation_ACER.gff3 > Acer.GFFannotation.gene.gff
grep $'\texon\t' EVM_Annotation_ACER.gff3 > Acer.GFFannotation.exon.gff # there are exons in the tRNA tracks but they are also in the CDS so I keep all
grep $'\tCDS\t'  EVM_Annotation_ACER.gff3 > Acer.GFFannotation.CDS.gff
grep $'\ttRNA\t' tRNA_Scan_Annotation_ACER.gff3 > Acer.GFFannotation.tRNA.gff

##### CREATE OTHER GENOME TRACKS

# extract scaffold lenghts

cat /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy6-[Acerv_assembly_v1.0_171209.fasta].fasta | awk '$0 ~ ">" {if (NR > 1) {print c;} c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > Acer.Chromosome_lenghts.txt

# extract scaffold names  	

cut -f1 Acer.Chromosome_lenghts.txt > Acer.Chromosome-Names.txt

#Sort GFF files for downstream use

sortBed -faidx Acer.Chromosome-Names.txt -i Acer.GFFannotation.gene.gff > Acer.GFFannotation.gene_sorted.gff

sortBed -faidx Acer.Chromosome-Names.txt -i Acer.GFFannotation.exon.gff > Acer.GFFannotation.exon_sorted.gff

sortBed -faidx Acer.Chromosome-Names.txt -i Acer.GFFannotation.CDS.gff > Acer.GFFannotation.CDS_sorted.gff

# Intergenic regions (By definition, these are regions that aren't genes. I can use complementBed to find all regions that aren't genes, and subtractBed to remove exons and create this track)

complementBed -i Acer.GFFannotation.gene_sorted.gff -sorted -g Acer.Chromosome_lenghts.txt | subtractBed -a - -b Acer.GFFannotation.exon_sorted.gff > Acer.GFFannotation.intergenic.gff # track resulting here has an overlap of the first base with the last base of the gene track so I corrected it below

awk '{print $1"\t"$2+1"\t"$3}' Acer.GFFannotation.intergenic.gff > Acer.GFFannotation.intergenic_corrected.gff #additionally the start region will be changed from 0 to 1 so need to be corrected.
sed -i 's/\<1\>/0/g' Acer.GFFannotation.intergenic_corrected.gff

#Non-coding Sequences (I can use complementBed to create a non-coding sequence track. This track can then be used to create an intron track)

complementBed -i  Acer.GFFannotation.exon_sorted.gff -g Acer.Chromosome_lenghts.txt > Acer.GFFannotation.noncoding.gff3

# Introns (The intersections betwen the non-coding sequences and genes are by definition introns)

intersectBed -a Acer.GFFannotation.noncoding.gff3 -b Acer.GFFannotation.gene_sorted.gff -sorted > Acer.GFFannotation.intron.gff3 # track resulting here has an overlap of the first base with the last base of the exon track so I corrected it below

awk '{print $1"\t"$2+1"\t"$3}' Acer.GFFannotation.intron.gff3 > Acer.GFFannotation.intron_corrected.gff3

# Untranslated regions 

flankBed -i Acer.GFFannotation.gene_sorted.gff -g /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy6-[Acerv_assembly_v1.0_171209.fasta].fasta.fai -l 0 -r 2000 -s | awk '{ gsub("gene","3prime_UTR",$3); print $0 }'| awk '{if($5-$4 > 3)print $0}'| tr ' ' '\t' > Acer.GFFannotation.3UTR.gff


# Putative promoter track

samtools faidx /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy6-\[Acerv_assembly_v1.0_171209.fasta\].fasta #index genome

flankBed -i Acer.GFFannotation.gene_sorted.gff -g /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/Genome_assembly2020_Baums_etal/Galaxy6-[Acerv_assembly_v1.0_171209.fasta].fasta.fai -l 1000 -r 0 -s | awk '{ gsub("gene","put_promoter",$3); print $0 }'| awk '{if($5-$4 > 3)print $0}'| tr ' ' '\t' > Acer.GFFannotation.put_promoter.gff
subtractBed -a Acer.GFFannotation.put_promoter.gff -b Acer.GFFannotation.gene_sorted.gff > Acer.GFFannotation.put_promoter_corrected.gff # when genes are close to each other promoter region overlaps with the gene. 

##### Create repetitive region tracks

# Run repeat masker

conda activate my_anaconda

RepeatMasker Galaxy6-[Acerv_assembly_v1.0_171209.fasta].fasta -species "all" -par 8 -gff -excln 1> stdout.txt 2> stderr.txt  	

conda deactivate
