###################################################
# Header: Analysis script X for project XYZ       #
###################################################

#Author:  
#Date:    


#Setup
.packages = c("janitor","tidyverse","here","rio","lubridate","skimr",
              "flextable")
# Install CRAN packages (if not already installed)
#.inst <- .packages %in% installed.packages()
#if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
lapply(.packages, require, character.only = TRUE)
warnings()

options(scipen = 999)

#Standard for ggplot2
theme_clean1 <- function() {
  theme_minimal(base_family = "TT Arial") +
    theme(legend.position = "none",
          plot.title = element_text(size = 16, margin = margin(10, 0, 0, 0)),
          plot.subtitle = element_text(size = 12, margin = margin(10, 0, 10, 0), color = "gray"),
          panel.background = element_rect(fill = NA, colour = "white"), 
          panel.grid.major = element_blank(),
          axis.ticks = element_blank())
}

#Consider setting up a specific workspace for this project.
#Consider structuring your analysis script according to your statistical
#analysis plan before you do analyses (unless this is a playground script).
#Consider using consecutive numbering as names in graphs/tables.
#Consider branding graphs and tables via caption in the labs call. See more 
#tips here: https://michaeltoth.me/you-need-to-start-branding-your-graphs-heres-how-with-ggplot.html

#Import masterfile----
master <- rio::import(here("data","master.rds"))

#Since the here package unfortunately produces quite a lot of conflicts
#with other packages (particularly from the tidyverse or with gtsummary and
#sometimes flextable), I recommend unloading the package before you 
#proceed to analyses.
#If you need to import files later (unlikely), prepend the line with:
#master <- rio::import(here::here("data","master.rds"))
detach("package:here", unload=TRUE)


########################
#1. Data description----
########################

##1.1 Table 01----

##1.2 Graph 01----
png("abb1.png", 
    width = 6, height = 4, units = 'in', res = 300)
ggplot(data, aes())+
  theme_clean1()
dev.off()


##1.3 Graph 03----

##############################
#2. Objective/Hypothesis 1----
##############################

##2.1 Data prep----

##2.2 t test for paired samples----

##2.3 Graph 04----
