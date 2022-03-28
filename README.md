# Coral surveys at four sites in Timor-Leste before and after 2016-2017 bleaching

This repository mirrors the UQ eSpace record for Kim et al., 2022 The condition of four coral reefs in Timor-Leste before and after the 2016-2017 marine heatwave in the journal Oceans (doi:10.1101/2020.11.03.364323). This repository contains the R related data and code for analysis and figures of the publication.

# 1. data

The data folder is the same as found in The University of Queensland eSpace repository at record number [UQ:7278446](https://espace.library.uq.edu.au/view/UQ:7278446) and doi:10.48610/7278446.

# 2. R code

The analysis and figures can be recreated using the R scripts below. All files can be knit except stableisotope_analysis.Rmd which requires a yes/no response in the console for one of the functions.

## CORAL REEF BENTHIC COMPOSISION AND HEALTH

Acropora_repeatedmeasANOVA.Rmd - This script contains statistical analyses and summary statistics involving Acroporid count data from belt transects. Produced Supplemental Figure A3.

genera_diversity.Rmd - Calculates the hard coral generic diversity captured on belt transects and subsequent plot Supplemental Figure A2. 

LIT_benthiccomposition_coralANOVA_bargraph.Rmd - This script contains statistical analyses of reef benthic composition and produces Figure 3.

stats-2015-2017-disease_compromised_states.Rmd - Produced statistics on proportion of hard coral that were diseased/compromised or healty, statistical analyses, and Figure 5.

## NUTRIENTS

nutrient_analysis_boxplot.Rmd - Satistical analyses and boxplot in Figure 6 of the seawater nutrient data collected in the 2015 surveys.

stableisotope_analysis.Rmd - Contains the statistical analyses for the macroalgal stable isotope data.

## TEMPERATURE 

TL_altemp_graph_stats_nodepth.Rmd - Constructs Figure 7 visualizing the in situ temperature logger and Coral Reef Watch Timor-Leste Virtual Station data.

CKlog-repeatedmeasures.Rmd - Satistical analysis of repeated measures test assessing for differences in temperature logger data by site with autocorrelation structure.

log_CRW_data_arima.Rmd - Testing models for coARMA autocorrelation structure for mixed effects model testing for differences in temperature by method (in situ temperature logger, satellite sea surface temperature from Coral Reef Watch). Produces corresponding plot of season x method interaction, Figure 8.

# 3. functions

Contains the get_best_arima.R file, a function for arima model in log_CRW_data_arima.Rmd.

# 4. figures

Figures from scripts output to this folder.
