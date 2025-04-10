#!/bin/bash


#### SCRIPT 5. PV_dmdp

## Aim: Get the aminoacid counts of the regions of interest

## Author: Joana L. Santos 17.08.2023 - PV_dmdp_0823

#######  VARIABLES 
	#update paths and names
	#main address
MAIN=/home/joana/PV_dmdp/

  #folder with the inputs - proteins parts
PPS1=analysis/COL/prot_parts_s1
PPS2=analysis/COL/prot_parts_s2


  #folder for the outputs - aminoacids counts general
AM1=analysis/COL/aminoacids_counts_1000_motifs_s1
AM2=analysis/COL/aminoacids_counts_1000_motifs_s2

  #folder aminocounts final files 
MC1=analysis/COL/aminoacids_counts_1000_motifs_s1/aminocounts
MC2=analysis/COL/aminoacids_counts_1000_motifs_s2/aminocounts

  #folder for final counts
FC1=analysis/COL/aminoacids_counts_1000_motifs_s1/final_counts
FC2=analysis/COL/aminoacids_counts_1000_motifs_s2/final_counts

  #FOLDER ratio
FR1=analysis/COL/aminoacids_counts_1000_motifs_s1/final_ratio
FR2=analysis/COL/aminoacids_counts_1000_motifs_s2/final_ratio

########## AMINOACID COUNTS PER GENE PER SAMPLE

  # create output folder 
mkdir $AM1
mkdir $AM2
  
  # create a folder per gene parts
for i in $(ls $PPS1); do mkdir $AM1/p_"${i%.fa}"; done
for i in $(ls $PPS2); do mkdir $AM2/p_"${i%.fa}"; done


  # use an identifier
for i in $(ls $PPS1); do sed 's/analysis.*-mRNA-/identifier/g' $PPS1/$i > temp && mv temp $PPS1/$i; done
for i in $(ls $PPS2); do sed 's/analysis.*-mRNA-/identifier/g' $PPS2/$i > temp && mv temp $PPS2/$i; done


  #mv each protein part to the correspondent folder
for i in $(ls $PPS1); do cp $PPS1/$i $AM1/p_${i%.fa}; done
for i in $(ls $PPS2); do cp $PPS2/$i $AM2/p_${i%.fa}; done


  #split multiple fasta by sample
for i in $(ls $AM1); do seqretsplit $AM1/$i/* -osdirectory2 $AM1/$i; done
for i in $(ls $AM2); do seqretsplit $AM2/$i/* -osdirectory2 $AM2/$i; done
  
  #take folders names 
ls $AM1 > $AM1/names.txt
cat $AM1/names.txt | grep "p_" | sed 's/://g' > $AM1/folders_names.txt

echo $AM1/p_* | xargs -n 1 cp scripts/script_amino_count_perfolder.sh

ls $AM2 > $AM2/names.txt
cat $AM2/names.txt | grep "p_" | sed 's/://g' > $AM2/folders_names.txt

echo $AM2/p_* | xargs -n 1 cp scripts/script_amino_count_perfolder.sh


  # create an extra script to count the aminoacids to run all at once and place into $AM1 and $AM2 folder
 
for script in script_amino_count_perfolder.sh; do
    for folder in $(cat $AM1/folders_names.txt); do
        ( cd $AM1/$folder; bash $script; ) &
    done
    wait
done

for script in script_amino_count_perfolder.sh; do
    for folder in $(cat $AM2/folders_names.txt); do
        ( cd $AM2/$folder; bash $script; ) &
    done
    wait
done

  #create aminocount.txt file  
cd $AM1
for f in p_*; do paste $f/seqid.txt $f/P $f/A $f/R $f/N $f/D $f/C $f/E $f/Q $f/G $f/H $f/I $f/L $f/K $f/M $f/F $f/S $f/T $f/W $f/Y $f/V $f/total_amino.txt | column -s $'\t' -t > $f/aminocount_$f.txt; done
cd $MAIN

cd $AM2
for f in p_*; do paste $f/seqid.txt $f/P $f/A $f/R $f/N $f/D $f/C $f/E $f/Q $f/G $f/H $f/I $f/L $f/K $f/M $f/F $f/S $f/T $f/W $f/Y $f/V $f/total_amino.txt | column -s $'\t' -t > $f/aminocount_$f.txt; done
cd $MAIN

  ## get a new folder to clean the files - remove identifier 

  # create the aminocount folder 
mkdir $MC1
mkdir $MC2

  #copy the aminocount tables into the new folder
cp $AM1/*/aminocount* $MC1/
cp $AM2/*/aminocount* $MC2/

  # remove identifier
for all in $(ls $MC1 ); do sed 's/>identifier//g' $MC1/$all > $MC1/mod.$all; done
for all in $(ls $MC2 ); do sed 's/>identifier//g' $MC2/$all > $MC2/mod.$all; done

  # creates header for the files
  #strand1
for file in $(ls $MC1/mod*.txt)
do
  awk 'NR==1 { print "genotype", "P"_FILENAME, "A"_FILENAME, "R"_FILENAME, "N"_FILENAME, "D"_FILENAME, "C"_FILENAME, "E"_FILENAME, "Q"_FILENAME, "G"_FILENAME, "H"_FILENAME, "I"_FILENAME, "L"_FILENAME, "K"_FILENAME, "M"_FILENAME, "F"_FILENAME, "S"_FILENAME, "T"_FILENAME, "W"_FILENAME, "Y"_FILENAME, "V"_FILENAME, "aminototal_"FILENAME}; 1' "$file" > temp && mv temp "$file"
done

  #strand2
for file in $(ls $MC2/mod*.txt)
do
  awk 'NR==1 { print "genotype", "P"_FILENAME, "A"_FILENAME, "R"_FILENAME, "N"_FILENAME, "D"_FILENAME, "C"_FILENAME, "E"_FILENAME, "Q"_FILENAME, "G"_FILENAME, "H"_FILENAME, "I"_FILENAME, "L"_FILENAME, "K"_FILENAME, "M"_FILENAME, "F"_FILENAME, "S"_FILENAME, "T"_FILENAME, "W"_FILENAME, "Y"_FILENAME, "V"_FILENAME, "aminototal_"FILENAME}; 1' "$file" > temp && mv temp "$file"
done

  #remove the copied files non modified 

rm $MC1/amin*
rm $MC2/amin*

  #get a new table including genotype and aminoacids per 1000 residues
mkdir $FC1
mkdir $FC2


  #removes header
for i in $(ls $MC1); do sed '1d' $MC1/$i > $FC1/c.$i; done
for i in $(ls $MC2); do sed '1d' $MC2/$i > $FC2/c.$i; done


  #calculate aminoacids per 1000 residues
mkdir $FR1
mkdir $FR2

for i in $(ls $FC1); do awk '{$23 = ($2*1000/$22); $24 = ($3*1000/$22); $25 = ($4*1000/$22); $26 = ($5*1000/$22);  $27 = ($6*1000/$22); $28 = ($7*1000/$22); $29 = ($8*1000/$22); $30 = ($9*1000/$22); $31 = ($10*1000/$22); $32 = ($11*1000/$22); $33 = ($12*1000/$22); $34 = ($13*1000/$22);  $35 = ($14*1000/$22); $36 = ($15*1000/$22); $37 = ($16*1000/$22); $38 = ($17*1000/$22); $39 = ($18*1000/$22); $40 = ($19*1000/$22); $41 = ($20*1000/$22); $42 = ($21*1000/$22); print}' $FC1/$i | awk '{print $1,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$40,$41,$42}' > $FR1/1000r.$i; done

for i in $(ls $FC2); do awk '{$23 = ($2*1000/$22); $24 = ($3*1000/$22); $25 = ($4*1000/$22); $26 = ($5*1000/$22);  $27 = ($6*1000/$22); $28 = ($7*1000/$22); $29 = ($8*1000/$22); $30 = ($9*1000/$22); $31 = ($10*1000/$22); $32 = ($11*1000/$22); $33 = ($12*1000/$22); $34 = ($13*1000/$22);  $35 = ($14*1000/$22); $36 = ($15*1000/$22); $37 = ($16*1000/$22); $38 = ($17*1000/$22); $39 = ($18*1000/$22); $40 = ($19*1000/$22); $41 = ($20*1000/$22); $42 = ($21*1000/$22); print}' $FC2/$i | awk '{print $1,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$40,$41,$42}' > $FR2/1000r.$i; done

  # create new header
for file in $(ls $FR1)
do
  awk 'NR==1 { print "genotype", "P_"FILENAME, "A_"FILENAME, "R_"FILENAME, "N_"FILENAME, "D_"FILENAME, "C_"FILENAME, "E_"FILENAME, "Q_"FILENAME, "G_"FILENAME, "H_"FILENAME, "I_"FILENAME, "L_"FILENAME, "K_"FILENAME, "M_"FILENAME, "F_"FILENAME, "S_"FILENAME, "T_"FILENAME, "W_"FILENAME, "Y_"FILENAME, "V_"FILENAME}; 1' $FR1/"$file"  > temp && mv temp $FR1/"$file"
done

for file in $(ls $FR2)
do
  awk 'NR==1 { print "genotype", "P_"FILENAME, "A_"FILENAME, "R_"FILENAME, "N_"FILENAME, "D_"FILENAME, "C_"FILENAME, "E_"FILENAME, "Q_"FILENAME, "G_"FILENAME, "H_"FILENAME, "I_"FILENAME, "L_"FILENAME, "K_"FILENAME, "M_"FILENAME, "F_"FILENAME, "S_"FILENAME, "T_"FILENAME, "W_"FILENAME, "Y_"FILENAME, "V_"FILENAME}; 1' $FR2/"$file" > temp && mv temp $FR2/"$file"
done

  #simplify filename 
for file in $(ls $FR1);
do sed -e 's+analysis/COL/aminoacids_counts_1000_motifs_s1/final_ratio/1000r.c.mod.aminocount_p_++g;s/.txt//g' $FR1/"$file" > temp && mv temp $FR1/"$file"; done
  
for file in $(ls $FR2);
do sed -e 's+analysis/COL/aminoacids_counts_1000_motifs_s2/final_ratio/1000r.c.mod.aminocount_p_++g;s/.txt//g' $FR2/"$file" > temp && mv temp $FR2/"$file"; done


########################### END SCRIPTING - USE R FOR CORRELATIONS WITH HABITAT VARIABLES

