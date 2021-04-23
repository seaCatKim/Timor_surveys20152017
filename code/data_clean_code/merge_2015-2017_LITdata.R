# Combine 2015 and 2017 Timor line intercept surveys
# Catherine kim
# April 23, 2021

## Read in data from coral health 15 m line intercept transects
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
colnames(comp15)[which(colnames(comp15) == "pSubSa")] <- "Substrate.Sand"
colnames(comp15)[which(colnames(comp15) == "pTurCy")] <- "Turf"
head(comp15)

comp17 <- read.csv("data/TL2017-benthiccomp-transect.csv")
comp17$X <- NULL
head(comp17)

comp.2yr <- rbind(comp15, comp17)
nrow(comp15)
nrow(comp17)
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

write.csv(comp.2yr, 'data/bencomp-transect-20152017.csv')




