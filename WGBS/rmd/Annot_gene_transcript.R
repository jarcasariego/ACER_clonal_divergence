### Relate Transcriptome annot with genome gene annotation 

#Read transcriptome annot (Matz)
ACER_seq2iso <-read.csv("../../../TagSeq/ACER_Transcriptome(Libro_etal_2013)/a.cervicornis_Libro etal 2013_annot_Matz/acer_seq2iso.tab", header=FALSE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(ACER_seq2iso) <- c("qseqid", "isoID")

ACER_iso2gene<-read.csv("../../../TagSeq/ACER_Transcriptome(Libro_etal_2013)/a.cervicornis_Libro etal 2013_annot_Matz/acer_iso2gene.tab", header=FALSE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(ACER_iso2gene) <- c("isoID","gene")

ACER_iso2go<-read.csv("../../../TagSeq/ACER_Transcriptome(Libro_etal_2013)/a.cervicornis_Libro etal 2013_annot_Matz/acer_defog_iso2go.tab", header=TRUE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(ACER_iso2go) <- c("isoID","GO")

ACER_iso2KOG<-read.csv("../../../TagSeq/ACER_Transcriptome(Libro_etal_2013)/a.cervicornis_Libro etal 2013_annot_Matz/acer_defog_iso2kogClass.tab", header=TRUE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(ACER_iso2KOG) <- c("isoID","KOG_cat")

ACER_iso2KEGG<-read.csv("../../../TagSeq/ACER_Transcriptome(Libro_etal_2013)/a.cervicornis_Libro etal 2013_annot_Matz/acer_iso2kegg.tab", header=TRUE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(ACER_iso2KEGG) <- c("isoID","KEGG.ID")

#Read magicblast results between transcripts (Libro etal) and genome fasta (Baums et al)
genome2seq <- read.csv("../data/Genome_trans_corr/Acer_trans2genome_coor.tab", header=FALSE, sep="\t", na.string="NA", stringsAsFactors = F, skip=0) 
colnames(genome2seq) <- c("chr","start","end","qseqid")
genome2seq$genoid <- paste(genome2seq$chr,":", genome2seq$start,"-",genome2seq$end, sep = "")
genome2seq <- genome2seq[,c(5,4)]

#merge datasets
genome2iso <- merge(genome2seq,ACER_seq2iso, by="qseqid")
genome2iso <- genome2iso[, -1]
gene2iso <- 

iso2gene <- merge(iso2gene,ACER_iso2gene, by="isoID")

#filter for high quality hits only
iso2gene <-iso2gene %>% 
  filter(.,evalue<1e-10) %>%
  arrange(.,sseqid,desc(pident)) %>%
  filter(.,pident>95)

write_delim(iso2gene, path = "data/Genome/pilon2iso2gene_LIBRO.tab", delim = "\t")

iso2gene <- read.delim("data/Genome/pilon2iso2gene_LIBRO.tab")

iso2gene_conv <- iso2gene[,c(1,3,14)]
iso2gene_conv$sseqid <- gsub("evm","gene",iso2gene_conv$sseqid)

#create gene2GO file
iso2GO <- merge(iso2gene_conv,ACER_iso2go, by= "isoID")
acerv_gene2GO <- iso2GO[, c(2,4)]  
colnames(acerv_gene2GO) <- c('gene', "GO")
write_delim(acerv_gene2GO, path = "data/Genome/acer.gene2GO.tab", delim = "\t")

#create gene2KOG file
iso2KOG <- merge(iso2gene_conv,ACER_iso2KOG, by= "isoID")
acerv_gene2KOG <- iso2KOG[, c(2,4)]  
colnames(acerv_gene2KOG) <- c('gene', "KOG_cat")
write_delim(acerv_gene2KOG, path = "data/Genome/acer.gene2KOG.tab", delim = "\t")

#create gene2KEGG file
iso2KEGG <- merge(iso2gene_conv,ACER_iso2KEGG, by= "isoID")
acerv_gene2KEGG <- iso2KEGG[, c(2,4)]  
colnames(acerv_gene2KEGG) <- c('gene', "KEGG.ID")
write_delim(acerv_gene2KEGG, path = "data/Genome/acer.gene2KEGG.tab", delim = "\t")

#create iso2pilon file
iso2pilon <- iso2gene[,c(1,3)]
colnames(iso2pilon) <- c("iso", "gene")
write_delim(iso2pilon, path = "data/Genome/acer.iso2pilon.tab", delim = "\t")
