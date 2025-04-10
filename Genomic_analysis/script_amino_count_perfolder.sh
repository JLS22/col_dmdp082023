#!/bin/bash

## Aim: Count the number of aminoacids per region of interest and per genotype

## Author: Joana L. Santos 17.08.2023
## Run the code:

# Count the number of each aminoacid within a region of interest
	# Note that "identifier" is referent to the name of the files

for f in identifier*; do grep -v '>' $f | grep -o 'P' | wc -l >> P; done
for f in identifier*; do grep -v '>' $f | grep -o 'A' | wc -l >> A; done
for f in identifier*; do grep -v '>' $f | grep -o 'R' | wc -l >> R; done
for f in identifier*; do grep -v '>' $f | grep -o 'N' | wc -l >> N; done
for f in identifier*; do grep -v '>' $f | grep -o 'D' | wc -l >> D; done
for f in identifier*; do grep -v '>' $f | grep -o 'C' | wc -l >> C; done
for f in identifier*; do grep -v '>' $f | grep -o 'E' | wc -l >> E; done
for f in identifier*; do grep -v '>' $f | grep -o 'Q' | wc -l >> Q; done
for f in identifier*; do grep -v '>' $f | grep -o 'G' | wc -l >> G; done
for f in identifier*; do grep -v '>' $f | grep -o 'H' | wc -l >> H; done
for f in identifier*; do grep -v '>' $f | grep -o 'I' | wc -l >> I; done
for f in identifier*; do grep -v '>' $f | grep -o 'L' | wc -l >> L; done
for f in identifier*; do grep -v '>' $f | grep -o 'K' | wc -l >> K; done
for f in identifier*; do grep -v '>' $f | grep -o 'M' | wc -l >> M; done
for f in identifier*; do grep -v '>' $f | grep -o 'F' | wc -l >> F; done
for f in identifier*; do grep -v '>' $f | grep -o 'S' | wc -l >> S; done
for f in identifier*; do grep -v '>' $f | grep -o 'T' | wc -l >> T; done
for f in identifier*; do grep -v '>' $f | grep -o 'W' | wc -l >> W; done
for f in identifier*; do grep -v '>' $f | grep -o 'Y' | wc -l >> Y; done
for f in identifier*; do grep -v '>' $f | grep -o 'V' | wc -l >> V; done

# Extract the id of the sequence
for f in identifier*; do grep '^>' $f >> seqid.txt; done

# Count the total aminoacids within a region of interest
for f in identifier*; do grep -v '>' $f | wc -c >> total_amino.txt; done