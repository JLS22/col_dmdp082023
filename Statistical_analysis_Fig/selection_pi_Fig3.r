### Selection stats - PI 
## Joana L. Santos 

### working directory
setwd("yourfolder")

### R libraries 
library(ggplot2)
library(dplyr)


### 1. Dataset

# Define dataset (fulldataset or without rockpools)
selection_stats="nonrockpools"

# Read data
stat=read.table(paste("selectionStats_",selection_stats,".txt",sep=""), h=T)
head(stat)
nrow(stat)
str(stat)

# Calculate PiN and PiS considering the number of sites, and PiN(PiS ratio)
stat$PiNf=as.numeric(stat$PiN)/as.numeric(stat$NumN)
stat$PiSf=as.numeric(stat$PiS)/as.numeric(stat$NumS)
stat$PiNPiS=stat$PiNf/stat$PiSf

### 2. Figure 3
# Organize dataset
level_order <- c('BUSCO', 'IMMUNE', 'COLLAGEN') 

# Plot PiN/PiS ratio
Pi=ggplot(stat, aes(x = genetype, y= PiNPiS)) +
  theme_classic()+
  geom_boxplot(aes(x = factor(genetype, level = level_order))) + 
  xlab("Gene set")+
  ylab("\u03c0N / \u03c0S") +	
  theme(legend.position = "none")

Pi

# Save plot 
ggsave(paste("PiNPiS.ratio.",selection_stats,".tiff",sep=""),
       plot = Pi,
       width = 11, height = 11, units = "cm", dpi = 300, device = "tiff")




### 3. Summary statistics

# Mean
stat1=subset(stat, !is.infinite(stat$PiN/PiS))
means2 = aggregate(stat1$PiNPiS,
                   by = list(stat1$genetype),
                   FUN = mean, na.rm=T)
means2

# Standard deviation
sd2 = aggregate(stat1$PiNPiS,
                by = list(stat1$genetype),
                FUN = sd, na.rm=T)
sd2

# Wilcoxon test

stat2=subset(stat1, !stat1$PiNPiS =="NaN")

  # subset data by gene set
immune=subset(stat2, stat2$genetype=="IMMUNE")
col=subset(stat2, stat2$genetype=="COLLAGEN")
busco=subset(stat2, stat2$genetype=="BUSCO")

  # Run tests
wilcox.test(immune$PiNPiS,col$PiNPiS)
wilcox.test(immune$PiNPiS,busco$PiNPiS)				
wilcox.test(col$PiNPiS,busco$PiNPiS)

