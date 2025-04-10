### dmdp082023 - PGLS - COUNTMAP PLOT

## Joana L. Santos 02.2024

### SET WORKING FILES
  #working directory path
yourpath="workingdirectory"
  # tree fie
treefile="your_tree_file.tree"
  # proline mean per sample
proline_mean="your_proline_overall_mean_per_sample_file.csv"
  # serine mean per sample
serine_mean="your_serine_overall_mean_per_sample_file.csv"
  # output file for proline
proline.pdf="proline_plot_dmdp.pdf"
  # output file for serine
serine.pdf="serine_plot_dmdp.pdf"
  # read bioclimatic variables per sample
bioclim="bioclim1.dmdp.data.csv"

### SET DIRECTORY
setwd(yourpath)

### LIBRARIES
library(phytools)
library(caper)


### READ TREE FILES
tree<-read.tree(treefile)

# midpoint rooting
tree_r<-midpoint.root(tree)


### READ PROLINE AND SERINE AVERAGE PER SAMPLE 

x<-as.matrix(read.csv(proline_mean,row.names=2))[,2] 

y<-as.matrix(read.csv(serine_mean,row.names=2))[,2] 


### COUNTMAP ANALYSIS PLOT

# proline
pdf(proline.pdf, width = 8, height = 11)
obj<-contMap(tree_r,x, fsize=c(0.3,0.5), lwd=2, plot=F,direction="leftwards")
n<-length(obj$cols)
obj$cols[1:n]<-colorRampPalette(c("#FDE725FF","#73D055FF","#1F968BFF","#39568CFF","#440154FF"), space="Lab")(n)
plot(obj,fsize=c(0.5,0.5), lwd=2, outline=F, type="phylogram")
dev.off()

#serine
pdf(serine.pdf, width = 8, height = 11)
obj<-contMap(tree_r,y, fsize=c(0.3,0.5), lwd=2, plot=F,direction="leftwards")
n<-length(obj$cols)
obj$cols[1:n]<-colorRampPalette(c("#FDE725FF","#73D055FF","#1F968BFF","#39568CFF","#440154FF"), space="Lab")(n)
plot(obj,fsize=c(0.5,0.5), lwd=2, outline=F, type="phylogram")
dev.off()


### PGLS ANALYSIS

## FORMAT TREE
wetree <- root(tree, 1)
wetree$root.edge=0
is.rooted(wetree )
wetree=multi2di(wetree1)
wetree$node.label=NULL

## READ INPUT FILES
  # Bioclimatic variables per sample
input_var=read.table(bioclim, sep=",", h=T)
colnames(input_var)=c("genotype","bio1","lineage")
  # Proline overall mean per sample
prol=read.table(proline_mean, sep=",",h=T)[, 2:3]
colnames(prol)=c("genotype","proline")
  # Serine overall mean per sample
ser=read.table(serine_mean, sep=",", h=T)[, 2:3]
colnames(ser)=c("genotype","serine")

## FORMAT DATA

  # Combine datasets
datasets_list <- list(input_var, prol, ser)
wedata <- Reduce(function(x, y) merge(x, y, by = "genotype", all = TRUE), datasets_list)

  # Check names of the tree and data file
name.check(wetree, wedata)

  # Name all variables
row.names(wedata)=wedata$genotype
name.check(wetree, wedata)

## PGLS 

  # Proline
comp.data<- comparative.data(phy = wetree, data = wedata, names.col = genotype, vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)
lsModel <-pgls(proline~bio1*lineage, data=comp.data, lambda = "ML")
summary(lsModel)
coef(lsModel)
anova(lsModel)

modsum=summary(lsModel)
r2 = modsum$adj.r.squared
my.p = modsum$coefficients[2,4]

plot(wedata$proline ~ wedata$bio1,
     xlab="Mean Annual Temperature (ºC)",
     ylab="Proline per 1000 residues")
abline(a = coef(lsModel)[1], b = coef(lsModel)[2])

 # Serine
comp.data<- comparative.data(phy = wetree, data = wedata, names.col = genotype, vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)
lsModel <-pgls(serine~bio1*lineage, data=comp.data, lambda = "ML")
summary(lsModel)
coef(lsModel)
anova(lsModel)

modsum=summary(lsModel)
r2 = modsum$adj.r.squared
my.p = modsum$coefficients[2,4]


plot(wedata$serine ~ wedata$bio1,
     xlab="Mean Annual Temperature (ºC)",
     ylab="Serine per 1000 residues")
abline(a = coef(lsModel)[1], b = coef(lsModel)[2])



