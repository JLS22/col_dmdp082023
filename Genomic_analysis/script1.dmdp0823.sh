##!/bin/bash

#### SCRIPT 1. dmdp-0823

## Aim: Get a fasta sequence per each sample and chromossome


### VARIABLES - change folder and files names accordingly


	# folder with the reference fasta files per chromossome 
FOLDERFASTACHR=data/fasta_ref/ 

	#list of contigs containing collagen genes
GENES=helping/uniq_contigs_collagen_genes_final.txt 


	# folder for outputs of fasta per chr per sample 
FOLDER1=analysis/COL/fasta_chr_sample_strand1
FOLDER2=analysis/COL/fasta_chr_sample_strand2
	
	#samples list
SAMPLES=helping/samples.list.txt

	#Folder with phased vcf files per contig
VCF=analysis/COL/phased_contig_collagen



### FASTA REF PER CHR - already made in collagen/vcf_fabienne/new_withphased



### FASTA PER CHR PER SAMPLE


#strand 1
mkdir $FOLDER1 

for i in $(cat $SAMPLES)
 do
  for a in $(cat $GENES);
   do cat $FOLDERFASTACHR/$a.fa |
    bcftools consensus --haplotype 1 --sample $i $VCF/phased_$a.recode.vcf.gz  > $FOLDER1/"$a"_"$i".fasta
   done
   done   
#strand 2
mkdir $FOLDER2 

for i in $(cat $SAMPLES)
 do
  for a in $(cat $GENES);
   do cat $FOLDERFASTACHR/$a.fa |
    bcftools consensus --haplotype 2 --sample $i $VCF/phased_$a.recode.vcf.gz > $FOLDER2/"$a"_"$i".fasta
   done
   done



### END ### run script 2

