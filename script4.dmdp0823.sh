#!/bin/bash

#### SCRIPT 4. PV - dmdp.0822023

## Aim: Get the preotein regions of interest - with the GLY-X-Y motifs

## Author: Joana L. Santos 17.08.2023 - PV_dmdp_0823

#######  VARIABLES 
	#update paths and names
	#main address
MAIN=/home/joana/PV_dmdp/

  #folder inputs - FASTA files with samples' protein sequences per gene 
PGENE1=analysis/COL/prot_gene_s1
PGENE2=analysis/COL/prot_gene_s2

  # regions of interest - produces my motifs_seq.sh script
SEQS=helping/info.regions.interest.txt 

  #folder outputs - protein parts per sample
PPS1=analysis/COL/prot_parts_s1
PPS2=analysis/COL/prot_parts_s2

######### PROTEIN PARTS
  #create new dir
mkdir $PPS1
mkdir $PPS2

  #copy files
cp $PGENE1/* $PPS1/
cp $PGENE2/* $PPS2/


  #Subset the protein sequences
while read a b c d; 
do
seqkit subseq -r $c:$d $PPS1/"$a"_prot.fa> $PPS1/"$a"_"$b".fa;
done < $SEQS

while read a b c d; 
do
seqkit subseq -r $c:$d $PPS2/"$a"_prot.fa> $PPS2/"$a"_"$b".fa;
done < $SEQS

  #rm the copied files



############## END - RUN SCRIPT 5 - AMINOACID COUNTS
  