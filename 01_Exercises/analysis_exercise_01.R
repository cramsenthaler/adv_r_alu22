#####################
# Header1           #
#####################

#Set up----
.packages = c("here", "rio", "tidyverse")
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
lapply(.packages, require, character.only=TRUE)

warnings()
theme_clean1 <- function() {
  theme_minimal()+
    theme(legend.position = "none",
          plot.title = element_text(size = 16, margin = margin(10,0,0,0)),
          plot.subtitle = element_text(size = 12, margin = margin(10,0,10,0), color = "gray"),
          panel.background = element_rect(fill = NA, color = "white"),
          panel.grid.major = element_blank(),
          axis.ticks = element_blank())
}
options(scipen = 999)

#Read in Master file
master <- readRDS(here("data","master.rds"))

#I want to produce table 1
table1 <- master %>% select(age, age_cat, sexf, akps, akpscatf)
table1 <- as_tibble(table1)
head(table1)
#unload packages
(.packages())
detach("package:here", unload=TRUE)
library(gtsummary)
table1 <- table1  %>%  
  tbl_summary(
    type = c(age, akps) ~ "continuous",
    digits = all_continuous() ~ 1,
    label = list(age ~ "Age (in years)",
                 age_cat ~ "Age (in years, categorised)",
                 sexf ~ "Sex",
                 akps ~ "Australia-modified Karnofsky Performance Status (AKPS)",
                 akpscatf ~ "AKPS, categorised"),
    statistic = all_continuous() ~ c("{median} ({min}, {max})"),
    missing_text = "Missing") 
table1 %>% 
  modify_caption("**Table 1. Patient Characteristics**") %>% 
  modify_header(label ~ "**Characteristic**") %>% 
  bold_labels()

table1 %>%
  as_flex_table() %>%
  flextable::save_as_image(path = "table1.png")

#Graph 1: ESAS items t1
esas <- master %>% select(esas1_t1:esas9_t1)

library("tidyverse")
str(esas)
#
for(i in 0:10) {                                   
  new <- rep(i, ncol(esas))                      
  esas[nrow(esas) + 1, ] <- new                
}
esas[1:ncol(esas)] <- lapply(esas[1:ncol(esas)], function(x) factor(x))
esas <- esas %>%
  tidyr::pivot_longer(cols = contains("esas"))%>%
  count(name, value, .drop = FALSE)
ipos_t1_h$value <- forcats::fct_explicit_na(ipos_t1_h$value, "Fehlend")
janitor::tabyl(ipos_t1_h$value)

ipos_bar$percent <- ipos_bar$n/45 * 100
ipos_bar$percent <- round(ipos_bar$percent, 1)

png("ipos_bar.png", 
    width = 8, height = 6, units = 'in', res = 300)
ggplot(ipos_bar, aes(fill=forcats::fct_rev(value), 
                     y=percent, x=forcats::fct_rev(ipos))) + 
  geom_bar(position="fill", stat="identity") + coord_flip() + 
  scale_fill_manual(values=abbicol) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 5L))+
  labs(title = "IPOS-DEM Items",
       subtitle = "(n = 45 Klient/innen)",
       y = "Prozent", x = "IPOS-Dem Items", fill = "Antwort") +
  theme_minimal() +
  theme(plot.title = element_text(size = 18, margin = margin(4, 0, 0, 0)),
        plot.subtitle = element_text(size = 12, margin = margin(4, 0, 10, 0), color = "gray"))
dev.off()
