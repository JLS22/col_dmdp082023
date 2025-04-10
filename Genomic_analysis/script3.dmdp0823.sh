#!/bin/bash

#### SCRIPT 3. pv_dmdp_082023

## Aim: Get a FASTA file of the CDS region per samples and chr

## Author: Joana L. Santos 20.09.2023 - PV_dmdp_0823


#######  VARIABLES 
	#update paths and names
	#main address
MAIN=/home/joana/PV_dmdp/

	#folder for the inputs - CDS FASTA files per gene and sample
CONC1=analysis/COL/fasta_conc_s1
CONC2=analysis/COL/fasta_conc_s2

	#folder for the outputs - Proteins sequences per gene and sample
PROT1=analysis/COL/prot_s1
PROT2=analysis/COL/prot_s2


	#folder for the outputs - proteins_final
FINAL_PROT1=analysis/COL/final_prot_s1
FINAL_PROT2=analysis/COL/final_prot_s2

	#folder for the outputs - Multi sample Fasta protein file
PGENE1=analysis/COL/prot_gene_s1
PGENE2=analysis/COL/prot_gene_s2

	#address of the genes codes
GENES=helping/collagen_simple_list.txt



########## GET PROTEIN SEQUENCES


mkdir $PROT1
mkdir $PROT2

  	# translation
while read a; do for i in $(ls $CONC1/$a); do transeq -sequence $CONC1/$a/$i -outseq $PROT1/protein_"$i"; done; done < $GENES
while read a; do for i in $(ls $CONC2/$a); do transeq -sequence $CONC2/$a/$i -outseq $PROT2/protein_"$i"; done; done< $GENES

	#if needed, the header of the protein files can be changed using the following 
for file in $(ls $PROT1); do awk '/>/{sub(">","&"FILENAME"")}1' $PROT1/$file > temp && mv temp $PROT1/$file;done
for file in $(ls $PROT2); do awk '/>/{sub(">","&"FILENAME"")}1' $PROT2/$file > temp && mv temp $PROT2/$file;done

	# remove part of the header  to contain only sample name and add an identifier for other analysis
for file in $(ls $PROT1/); do sed -e 's/\(^.*chr[0-9]\+_\)\(.*\)\(.fasta.*$\)/>identifier\2/' $PROT1/$file > $FINAL_PROT1/final_$file; done 
for file in $(ls $PROT2/); do sed -e 's/\(^.*chr[0-9]\+_\)\(.*\)\(.fasta.*$\)/>identifier\2/' $PROT2/$file > $FINAL_PROT2/final_$file; done 

	# Organize files in a folder per gene
for i in $(cat $GENES); do mkdir $FINAL_PROT1/$i; done
for i in $(cat $GENES); do mkdir $FINAL_PROT2/$i; done

for i in $(cat $GENES); do mv $FINAL_PROT1/final_mod_protein_concatenated_"$i"*.fasta $FINAL_PROT1/$i/; done
for i in $(cat $GENES); do mv $FINAL_PROT2/final_mod_protein_concatenated_"$i"*.fasta $FINAL_PROT2/$i/; done

############ CREATE A MULTIPLE PROTEIN FASTA PER GENE 
mkdir $PGENE1
mkdir $PGENE2

while read a; do for file in $(ls $FINAL_PROT1/$a); do cat $FINAL_PROT1/$a/$file >> $PGENE1/"$a"_prot.fa; done; done < $GENES
while read a; do for file in $(ls $FINAL_PROT2/$a); do cat $FINAL_PROT2/$a/$file >> $PGENE2/"$a"_prot.fa; done; done < $GENES

####### END ## RUN SCRIPT 4 CUT REGIONS OF INTEREST: script4