#### dmdp082023 - FIGURE 2 AND STATISTICAL ANALYSIS OF PROLINE AND SERINE CONTENT WITH BIOCLIM AND TEMPERATURE TOLERANCE DATA

 

## REQUIRED LIBRARIES
library(ggplot2)
library(cowplot)

## READ DATASETS - overall mean of proline and serine across strands with gps and bioclim data included 

# read dataset
pro=read.table("pro.txt", h=T)
ser=read.table("ser.txt", h=T)

# organize dataset
pro$order=as.character(pro$order)
ser$order=as.character(ser$order)


### FIGURE 2

# proline plot
pro_plot=ggplot(pro, aes(x=bio1.txt, y=overall_mean, col=order)) +
  theme_classic() +
  stat_smooth(data=pro, method = "lm",formula = y ~ x, geom = "smooth", level=0.95, col="black", size=1.2)+
  geom_point(aes(shape=order), size=4) + 
  scale_shape_manual(values=c(15,16,17))+
  scale_colour_manual(values=c("#fe8088","#0097a4","#ab6e77"))+
  labs(y="Proline per 1000 residues")+
  scale_x_continuous(expand = c(0.01,-0.01))+
  theme(axis.text = element_text(size=18),
        axis.title = element_text(size=20), 
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        legend.position = "none",
        plot.margin = margin(20, 10, 10, 10))

# serine plot

ser_plot=ggplot(ser, aes(x=bio1.txt, y=overall_mean)) +
  theme_classic() +
  stat_smooth(data=ser, method = "lm",formula = y ~ x, geom = "smooth", level=0.95, col="black", size=1.2)+
  geom_point(aes(shape=order, col=order), size=4) + 
  scale_shape_manual(values=c(15,16,17))+
  scale_colour_manual(values=c("#fe8088","#0097a4","#ab6e77"))+
  labs(x="Annual Mean Temperature ºC", y="Serine per 1000 residues")+
  scale_x_continuous(expand = c(0.01,-0.01))+
  theme(axis.text = element_text(size=18),
        axis.title = element_text(size=20),
        legend.position = "none",
        plot.margin = margin(22, 10, 10, 10))

#get legend
leg=ggplot(pro, aes(x=bio1.txt, y=overall_mean, col=order)) +
  theme_classic() +
  geom_point(aes(shape=order, col=order), size=4) + 
  scale_shape_manual(values=c(15,16,17),
                     labels=c("North America","Western Eurasia", "East Asia"),
                     name=c("Lineage:"))+
  scale_colour_manual(values=c("#fe8088","#0097a4","#ab6e77"),
                      labels=c("North America","Western Eurasia", "East Asia"),
                      name=c("Lineage:"))+
  theme(axis.text = element_text(size=18),
        axis.title = element_text(size=20), 
        legend.position = "bottom",
        legend.text = element_text(size=18),
        legend.title = element_text(size=20),
        plot.margin = margin(10, 10, 10, 10))

get_leg=get_legend(leg)

# Join plots 
fig2 = plot_grid(pro_plot, ser_plot, get_leg, 
                 ncol = 1, 
                 rel_heights = c(1, 1.1, 0.3),
                 labels = c("A", "B"),
                 label_size = 18,
                 label_x = 0,  # Move labels closer to the y-axis
                 label_y = 1.01,  # Keep labels at the top of each plot
                 hjust = 0,  # Left-align labels
                 align = "v",
                 axis="l")


# Define figure dimensions in inches
width_cm <- 18
height_cm <- 22
width_in <- width_cm / 2.54  # Convert cm to inches
height_in <- height_cm / 2.54

# Save as TIFF
ggsave("fig2.tiff", plot = fig2, width = width_in, height = height_in, dpi = 200, units = "in", device = "tiff")


### SUMMARY STATISTICS  

# define the aminoacid i.e., proline ou serine 
amino="pro"
al=pro

# Subset data by lineage
wa=subset(al, al$lineage=="WesternEurasia")
ea=subset(al, al$lineage=="EastAsia")
na=subset(al, al$lineage=="NorthAmerica")

# Stats
mean(al$overall_mean)
max(al$overall_mean)
min(al$overall_mean)
sd(al$overall_mean)


mean(wa$overall_mean)
max(wa$overall_mean)
min(wa$overall_mean)
sd(wa$overall_mean)

mean(na$overall_mean)
max(na$overall_mean)
min(na$overall_mean)
sd(na$overall_mean)

mean(ea$overall_mean)
max(ea$overall_mean)
min(ea$overall_mean)
sd(ea$overall_mean)

# Statistical model 
# Western Eurasia
lm<-lm(overall_mean~bio1.txt, data=wa)
modm=summary(lm)
modm
coef(lm)
af <- anova(lm)
af
afss <- af$"Sum Sq"
print(cbind(af,PctExp=afss/sum(afss)*100)) 


# East Asia
lm<-lm(overall_mean~bio1.txt, data=ea)
modm=summary(lm)
modm
coef(lm)
af <- anova(lm)
af
afss <- af$"Sum Sq"
print(cbind(af,PctExp=afss/sum(afss)*100))

# North America
lm<-lm(overall_mean~bio1.txt, data=na)
modm=summary(lm)
modm
coef(lm)
af <- anova(lm)
af
afss <- af$"Sum Sq"
print(cbind(af,PctExp=afss/sum(afss)*100))

### TEMPERATURE TOLERANCE

# read seefeldt et al. data

see=read.table("seefeldt_data.csv", sep=";", h=T)
head(see)
colnames(see)[1]=c("geno")

# merge with the aminoacid data 

allsee=merge(see, al)
nrow(allsee)
nrow(see)

# Subset samples only from summer-active populations of the Western Eurasian lineage
allseewasum=subset(allsee, allsee$summer_active==1 && allsee$lineage=="WesternEurasia")
nrow(allseewasum)

# Summary statistics of temperature tolerance
mean(allseewasum$maxtempsurvival)
sd(allseewasum$maxtempsurvival)


# Statistical model
lmsw<-lm(maxtempsurvival~overall_mean, data=allseewasum)
modm=summary(lmsw)
modm
coef(lmsw)




