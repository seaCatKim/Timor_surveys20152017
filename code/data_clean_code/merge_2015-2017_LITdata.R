# Combine 2015 and 2017 Timor line intercept surveys
# Catherine kim
# April 23, 2021

## Read in data from coral health 15 m line intercept transects
library(here)
comp15.l <- read.csv(here::here("data/TL2015-BenthicCategories_Site_Depth-long.csv"))
comp15.l$X <- NULL  # remove first column which is row number
head(comp15.l)

comp15 <- spread(comp15.l, Major.Category, sum.Area)
comp15$Pop <- NULL
comp15$Year <- 2015

# rename major benthic categories
colnames(comp15)[which(colnames(comp15) == "pCCA")] <- "CCA"
colnames(comp15)[which(colnames(comp15) == "pCoral")] <- "HardCoral"
colnames(comp15)[which(colnames(comp15) == "pInv")] <- "Invert"
colnames(comp15)[which(colnames(comp15) == "pMA")] <- "Macroalgae"
colnames(comp15)[which(colnames(comp15) == "pSoft")] <- "SoftCoral"
colnames(comp15)[which(colnames(comp15) == "pSubSa")] <- "Substrate/Sand"
colnames(comp15)[which(colnames(comp15) == "pTurCy")] <- "Turf"
head(comp15)

## TL 2017 Survey - LIT w turf

library(plyr)
library(dplyr)
library(tidyr)
library(Rmisc)
library(reshape2)

tur <- read.csv(here::here("data/LIT-master-2017-turf.csv"))
head(tur)

tur.ben <- tur %>%
   group_by(Site, Depth, Transect, Major.Category) %>%
   dplyr::summarise(totcat = sum(Area))%>%
   spread(Major.Category,totcat)
tur.ben[is.na(tur.ben)] <- 0
head(tur.ben)

tur.ben$tot <- apply(tur.ben[,4:ncol(tur.ben)], 1, sum)
tur.ben$tot

w <- rep(1, each = 24)
for( i in c(4:ncol(tur.ben))){
   x <- tur.ben[,i]/tur.ben$tot*100
   w <- cbind(w, x)
}
head(w)

tur.ben <- as.data.frame(tur.ben)
head(tur.ben)
ben.p <- cbind(tur.ben[,1:3], w[,2:ncol(w)])
head(ben.p)
colnames(ben.p) <- colnames(tur.ben)

ben.p$HardCoral <- ben.p$Coral + ben.p$FreeCoral
ben.p$Coral <- NULL
ben.p$FreeCoral <- NULL
ben.p$'Substrate/Sand' <- ben.p$LooseSub + ben.p$Substrate + 
   ben.p$Rubble + ben.p$Sand
ben.p$LooseSub <- NULL
ben.p$Substrate <- NULL
ben.p$Rubble <- NULL
ben.p$Sand <- NULL

ben.p$tot <- apply(ben.p[,4:10], 1, sum)
ben.p$tot
ben.p$tot <- NULL

Site2 <- rep(c("Rural-N", "Urban-E", "Urban-W", "Rural-E"), each = 6)
ben.p$Site2 <- Site2

ben.p$Year <- "2017"

# write.csv(ben.p, "TL2017-benthiccomp-transect.csv")
# comp17 <- read.csv("data/TL2017-benthiccomp-transect.csv")
ben.p$X <- NULL
head(ben.p)

comp.2yr <- rbind(comp15, ben.p)
nrow(comp15)
nrow(ben.p)
nrow(comp.2yr)
head(comp.2yr)

comp.2yr$Year <- as.factor(comp.2yr$Year)

# add unique transect ids
library(tidyr)
library(dplyr)
comp.2yr$long_id <- as.factor(paste(comp.2yr$Site, comp.2yr$Depth, comp.2yr$Transect, sep = "_"))

ids <- read.csv("data/unique_ids_wnum_manatutu.csv")

comp.2yr <- comp.2yr %>% 
   inner_join( ids, by = 'long_id') %>% 
   select(Year, Site2, Site, Depth, Transect, num_id, CCA:Turf)

comp.2yr$long_id <- NULL

## summarized by coral site depth year
coral.ave <- comp.2yr %>% 
   group_by(Site2, Depth, Year) %>% 
   dplyr::summarize(corave = mean(HardCoral),
                    corSE = sd(HardCoral)/sqrt(n()))

write.csv(comp.2yr, 'data/bencomp-transect-20152017.csv', row.names = F)




