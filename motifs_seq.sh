#!/bin/bash
## Aim: Get the regions in the protein sequence with repetitions of 20 of more Gly-Xaa-Yaa motifs

## Author: Joana L. Santos 18.09.2023 - PV_dmdp_0823

## Variables
FOLDER=data/col_proteins_fasta #direct to folder with all the protein fasta sequences

## Run the code
# get the name of each protein fasta file
for file in $(ls $FOLDER)
do 
grep -v ">"  $FOLDER/$file > temp
PROTFILE=temp


# Identify the region of interest of each collagen gene, considering when there is more than one region
PARTS=$(grep -Eo '(G[A-Z]{2}){20,}' $PROTFILE)
PARTSN=$(grep -Eo '(G[A-Z]{2}){20,}' $PROTFILE | wc -l)

declare -A SEQ=()

# Get each region of interest to a distinct variable 
for i in $( seq 1 $PARTSN)
do
  SEQ[$i]=$(echo $PARTS | grep -Eo '(G[A-Z]{2}){20,}' | sed -n "${i} p")
  echo ${SEQ[$i]}
done

## Get the initial part of each region of interest

declare -A STARTs=()

for i in $( seq 1 $PARTSN)
do 
  VAR=$(echo ${SEQ[$i]})
  STARTs[$i]=$(awk -v pat=$VAR 'match($0,pat){print RSTART}' $PROTFILE )
  echo ${STARTs[$i]}
done

# Get the end part of each region of interest
declare -A REVs=()
declare -A ENDs=()

for i in $( seq 1 $PARTSN)
do 
  VAR2=$(echo ${SEQ[$i]} | rev)
  SIZE=$(cat $PROTFILE| wc -c)
  REVs[$i]=$(rev $PROTFILE | awk -v pat=$VAR2 'match($0,pat){print RSTART}')
  REVn=$(echo ${REVs[$i]})
  ENDs[$i]=$(($SIZE - $REVn -1)) 
  echo ${ENDs[$i]}
  
  
# Create a final file with information of the Start and End codons of each region of interest for each gene

START=$(echo ${STARTs[$i]})
END=$( echo ${ENDs[$i]})
PART=$(echo $i)
echo ${file%_trans.fa} part"$PART" $START $END >> info.regions.interest.txt
done
rm temp

done

## End