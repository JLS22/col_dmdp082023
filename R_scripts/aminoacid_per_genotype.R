##### dmdp082023 - AMINOACID CONTENT PER GENOTYPE AND STRAND #######
#Joana Santos 22.09.2023

##### WORKING DIRECTORY
setwd("yourpath/")

##### LIBRARIES
library(matrixStats)

##### DESCRIPTION
# This scripts creates an average of each aminoacid content among all collagen genes per genotype. It requires to update strand folder name and output files. Aminoacid content per 1000 aminoacids

##### CODE PER AMINOACID 

## Do for s1 and s2

###### PROLINE 
setwd("final_ratio_s1")
rm(dataset)
rm(fdataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V2))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of proline 1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "proline1000aminoacids_final_ratio_s1.txt", row.names = F)

###### alanine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V3))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "alanine1000aminoacids_final_ratio_s1.txt", row.names = F)



###### arginine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V4))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "arginine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### asparagine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V5))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "asparagine1000aminoacids_final_ratio_s1.txt", row.names = F)


###### aspartic acid

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V6))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "asparticacid1000aminoacids_final_ratio_s1.txt", row.names = F)

###### cysteine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V7))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "cysteine1000aminoacids_final_ratio_s1.txt", row.names = F)


###### Glutamic Acid

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V8))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "glutamicacid1000aminoacids_final_ratio_s1.txt", row.names = F)


###### glutamine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V9))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "glutamine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### glycine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V10))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "glycine1000aminoacids_final_ratio_s1.txt", row.names = F)


###### histidine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V11))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "histidine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### isoleucine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V12))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "leucine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### leucine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V13))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "isoleucine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### lysine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V14))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "lysine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### methionine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V15))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "methionine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### phenylalanine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V16))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "phenylalanine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### serine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V17))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "serine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### threonine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V18))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "threonine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### tryptophan

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V19))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "tryptophan1000aminoacids_final_ratio_s1.txt", row.names = F)

###### tyrosine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V20))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "tyrosine1000aminoacids_final_ratio_s1.txt", row.names = F)

###### valine

setwd("final_ratio_s1")
rm(fdataset)
rm(dataset)
rm(mean_gen)
for (data in list.files(pattern="*txt")){
  
  # Create the first data if no data exist yet
  if (!exists("dataset")){
    dataset <- read.table(data, header=FALSE)
  }
  
  # if data already exist, then append it together
  if (exists("dataset")){
    tempory <-read.table(data, header=FALSE)
    dataset <-unique(cbind(dataset, tempory$V21))
    rm(tempory)
  }
}

# REMOVE Dataset$v2

fdataset<-subset(dataset, select = -c(2:21))

# Give the proper header

names(fdataset) <- fdataset[1,]
fdataset <- fdataset[-1,]  
head(fdataset) 

#set as numeric
fdataset[,2:ncol(fdataset)]<- sapply(fdataset[,2:ncol(fdataset)],as.numeric)
str(fdataset)


#give mean and sd of  1000 aminoacids per genotype
fdataset$mean<-rowMeans(fdataset[,c(2:ncol(fdataset))], na.rm = T)
fdataset$sd<-rowVars((as.matrix(fdataset[,c(2:(ncol(fdataset)-1))]))/sqrt(20), na.rm = T)
head(fdataset)
## look into the mean and sd of proline per genotype 

mean_gen<-fdataset[, c(1,(ncol(fdataset)-1),ncol(fdataset))]
head(mean_gen)

setwd("..")

## write table 
write.table(mean_gen, "valine1000aminoacids_final_ratio_s1.txt", row.names = F)

setwd("..")