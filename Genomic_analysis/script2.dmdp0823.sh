#!/bin/bash

#### SCRIPT 2. Daphnia project fo all samples and genes


## Aim: Get a FASTA file of the CDS region per samples and chr

## Author: Joana L. Santos 11.08.2023 - PV_dmdp_0823


#######  VARIABLES 
	#update paths and names
	#main address
MAIN=/home/joana/PV_dmdp/

	#folder to create the outputs - CDS fasta per chr and sample
FOLDER1=analysis/COL/bedtools_output_strand1
FOLDER2=analysis/COL/bedtools_output_strand2

	#address of the genes codes - i.e., information of translation direction
PLUSGENES=helping/plus_strand_collagen_genes.txt 
MINUSGENES=helping/minus_strand_collagen_genes.txt

	#address of the genes codes and respective contig 
RPLUSGENES=helping/req_plus_strand_collagen_genes.txt
RMINUSGENES=helping/req_minus_strand_collagen_genes.txt 

	#adress of the fasta files per chr per sample
FASTAchr1=analysis/COL/fasta_chr_sample_strand1
FASTAchr2=analysis/COL/fasta_chr_sample_strand2

	#adress for the gff files from the reference data
GFFs=data/ref_gtf/gtf_collagen/CDS

	#adress sample list 
SAMPLES=helping/samples.list.txt

	#output folder for the complete CDS fasta sequence of the gene - i.e., after combining the diverse CDS part of a gene
CONC1=analysis/COL/fasta_conc_s1
CONC2=analysis/COL/fasta_conc_s2

####### OBTAIN A FASTA OF THE CDS REGION PER GENE PER SAMPLE

mkdir $FOLDER1
mkdir $FOLDER2

	#create folder for each gene 
	
for i in $(cat $PLUSGENES); do mkdir  $FOLDER1/$i; done
for i in $(cat $MINUSGENES); do mkdir  $FOLDER1/$i; done


for i in $(cat $PLUSGENES); do mkdir  $FOLDER2/$i; done
for i in $(cat $MINUSGENES); do mkdir  $FOLDER2/$i; done

	# get CDS independent for forward and reverse genes

	#strand1

	## for forward 
while read a b; do for file in $(cat $SAMPLES); do bedtools getfasta -fi $FASTAchr1/"$b"_"$file".fasta -bed $GFFs/$a.CDS.gtf > $FOLDER1/"$a"/"$a"_"$b"_"$file".fasta ; done; done < $RPLUSGENES

	## for reverse 
while read a b; do for file in $(cat $SAMPLES); do bedtools getfasta -s -fi $FASTAchr1/"$b"_"$file".fasta -bed $GFFs/$a.CDS.gtf > $FOLDER1/"$a"/"$a"_"$b"_"$file".fasta ; done; done < $RMINUSGENES

	#strand2
	## for forward 
while read a b; do for file in $(cat $SAMPLES); do bedtools getfasta -fi $FASTAchr2/"$b"_"$file".fasta -bed $GFFs/$a.CDS.gtf > $FOLDER2/"$a"/"$a"_"$b"_"$file".fasta ; done; done < $RPLUSGENES

	## for reverse 
while read a b; do for file in $(cat $SAMPLES); do bedtools getfasta -s -fi $FASTAchr2/"$b"_"$file".fasta -bed $GFFs/$a.CDS.gtf > $FOLDER2/"$a"/"$a"_"$b"_"$file".fasta ; done; done < $RMINUSGENES


#######  GET A CONTINUOUS FASTA FILE PER GENE



## concatenate fasta files        
mkdir $CONC1
mkdir $CONC2

mkdir $CONC1/reverse
mkdir $CONC2/reverse

#for reverse genes - use tac
for i in $(cat $MINUSGENES); do tac $FOLDER1/$i/*.fasta > $CONC1/$i; done
for i in $(cat $MINUSGENES); do tac $FOLDER2/$i/*.fasta > $CONC21/$i; done

#copy forward
for i in $(cat $PLUSGENES); do cp $FOLDER1/$i/*.fasta $CONC1/; done
for i in $(cat $PLUSGENES); do cp $FOLDER2/$i/*.fasta $CONC2/; done

#concatenate
for file in $(ls $CONC1); do cat $CONC1/$file | grep -v '>' |  awk '{print}' ORS='' > $CONC1/concatenated_"$file"; done
for file in $(ls $CONC2); do cat $CONC2/$file | grep -v '>' |  awk '{print}' ORS='' > $CONC2/concatenated_"$file"; done


## organise in separated folders
for i in $(cat $MINUSGENES); do mkdir $CONC1/$i; done
for i in $(cat $MINUSGENES); do mkdir $CONC2/$i; done
for i in $(cat $PLUSGENES); do mkdir $CONC1/$i; done
for i in $(cat $PLUSGENES); do mkdir $CONC2/$i; done

for i in $(cat $MINUSGENES); do mv $CONC1/concatenated_"$i"*.fasta $CONC1/$i/; done
for i in $(cat $MINUSGENES); do mv $CONC2/concatenated_"$i"*.fasta $CONC2/$i/; done
for i in $(cat $PLUSGENES); do mv $CONC1/concatenated_"$i"*.fasta $CONC1/$i/; done
for i in $(cat $PLUSGENES); do mv $CONC2/concatenated_"$i"*.fasta $CONC2/$i/; done

#remove the copied files 


###################### END ## RUN SCRIPT 3 :