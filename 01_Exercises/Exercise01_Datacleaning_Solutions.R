################################################################
#                 Exercise 1: Data cleaning                    #
################################################################

#Author: Christina
#Date: 17/10/2022

#You can also do this exercise in a markdown document (see notebook).
#Rather than cleaning my file you may use this time to work on your
#own data cleaning problems or you might want to read through other
#chapters of the handbook.

#Open the raw_exercise.csv file. Using the templates provided (and your
#knowledge), try to diagnose the problems in this file and come up
#with a plan for cleaning it. Also try to determine the functions you
#will use to do so. Please also use the following pointers below.
#If you want, you can come up with a cleaning dictionary.

#Set-up chunk----
#Set up might also entail creating an R project in the exercise folder.

#Setting up packages vector
.packages <- c("here","rio","lubridate","tidyverse","janitor", "skimr")
lapply(.packages, require, character.only=TRUE)
warnings()
options(scipen=999)

#1. Raw file data import----
#You might have to do someting when you read in the data.
exercise <- import("raw_exercise01.xlsx", skip = 1)
View(exercise)
skim(exercise)
glimpse(exercise)
str(exercise)

#2. Cleaning column names----
#Definitely look at date variables
#Also recode the 10 symptoms such that they read esas01 to esas10
names(exercise)
clean <- exercise %>% 
  janitor::clean_names()
names(clean)

#still some manual cleaning to do
clean <- clean %>% 
  rename(
    date_entry = date_entry_ward,
    date_last = last_date)
names(clean)

#coming up with a very simple vector holding names
esas <- rep("esas", times = 9)
numbers <- 1:9
esas <- str_c(esas, numbers)
t1 <- rep("t1", times = 9)
t2 <- rep("t2", times = 9)
esast1 <- str_c(esas, t1, sep = "_")
esast2 <- str_c(esas, t2, sep = "_")

names(clean)[9:17] <- esast1
names(clean)[19:27] <- esast2

names(clean)

#3. Dealing with structural problems----
#Decide whether you want to keep this in wide format (I would for now).
#Think about what you can and cannot do in wide format.
#For the brave: Read through the pivoting chapter https://www.epirhandbook.com/en/pivoting-data.html
#and try a pivoted version. You will then calculate the date difference 
#between time points in a different way (grouped data).

#I would keep in wide format for now, mainly because pivoting later with
#subset of data much easier for analyses.
#Structural problems with data are:
str(clean)
#age, weight variable are character but should be numeric!
janitor::tabyl(clean$age)
clean$age <- as.numeric(clean$age)
Hmisc::describe(clean$age)

janitor::tabyl(clean$height)
clean$height <- as.numeric(clean$height)
Hmisc::describe(clean$height)

#There is another structural issue which we should address: missing values.
#Check for Missing values and code all '999' as NA.
skim(clean)
#999 are missing data
clean <- clean %>% 
  na_if(999)


#4. Selecting or re-ordering columns----
#Reorder columns so that patient characteristics are at the beginning.
#Have all data belonging to a time point consecutively arranged.
#Yep, that's already done.

#5. Deduplication----
#Check whether there are duplicated cases.
#Well, there aren't but...
length(unique(clean$patient_id))
janitor::tabyl(clean$patient_id)
#The first patients with numbers g0101001 to g0101019 have three or two entries.
#They most likely have been admitted to the ward more than once.
#What to do?
clean <- clean %>% 
  arrange(patient_id, date_entry)
#Oh dear, these aren't cases that came twice or thrice, these are different
#people with the same ID number given more than once.
#Either give them new ID numbers or omit ID numbers altogether.
#Just checking:
clean_distinct <- clean %>% 
  distinct()

#Overwrite the patient_id column
clean$patient_id <- 1:nrow(clean)
clean$patient_id


#6. Column creation or transformation----
#Calculate the bmi for each patient in the file.
class(clean$weight)
clean$weight <- as.numeric(clean$weight)
class(clean$height)
clean <- clean %>% 
  mutate(bmi = weight / (height/100)^2)

psych::describe(clean$bmi)
Hmisc::describe(clean$age)

#Check column classes and transform wrong column classes.
#Already done.
#We caught the last one (hopefully) up there.

#Recode each esas symptom variable such that this is yes for values >= 5
#and no for values <5.
#Need to do this for both t1 and t2.
clean_esast1 <- clean %>% 
  select(ends_with("t1")) %>% 
  mutate_all(., funs(ifelse(. >=5, 1, 0)))
colnames(clean_esast1) <- paste(colnames(clean_esast1),"c",sep="")
names(clean_esast1)
#the same for t2
clean_esast2 <- clean %>% 
  select(ends_with("t2")) %>% 
  mutate_all(., funs(ifelse(. >=5, 1, 0)))
colnames(clean_esast2) <- paste(colnames(clean_esast2),"c",sep="")
names(clean_esast2)

#Now we bind back the variables

cleannew <- cbind(clean, clean_esast1, clean_esast2)
View(cleannew)


#7. Re-coding variables----
#Calculate age categories using quantile breaks
quantile(cleannew$age,
         probs = c(0, .25, .50, .75, 1),   # specify the percentiles you want
         na.rm = TRUE) 
#Breaks should be at 59, 67, 76
cleannew <- cleannew %>% 
  mutate(age_cat = cut(age,
                       breaks = quantile(
                         age,
                         probs = c(0, .25,.50,.75, 1),
                         na.rm = TRUE),
                       include.lowest = TRUE))
janitor::tabyl(cleannew$age_cat)
janitor::tabyl(cleannew$age)

#Recode performance status akps with a cutoff of <= 50 
#for low performance status.
cleannew <- cleannew %>% 
  mutate(akpscat = ifelse(akps <= 50, 1, 0))
cleannew %>%janitor::tabyl(akps, akpscat)

#8. Setting up factor variables----
#Recode factor variables with factor levels.
#Also give recoded variables under 7) the proper factor levels.

table(cleannew$severity, useNA = "always")
#Recode the 3 to NA!
cleannew$severity <- cleannew$severity %>% 
  na_if(3)
table(cleannew$severity, useNA = "always")

names(cleannew)
#Factor variables are 
#sex
class(cleannew$sex)
table(cleannew$sex)
cleannew$sexf <- factor(cleannew$sex,
                       levels = c("f","m"),
                       labels = c("women","men"))
levels(cleannew$sexf)
sum(is.na(cleannew$sex))

#age_cat
class(cleannew$age_cat)
levels(cleannew$age_cat)

#akps_cat
table(cleannew$akpscat, useNA = "always")
#Either use forcats _explicit_na to make factor level for missing
#Or use exclude = NULL in normal factor call:
cleannew$akpscatf <- factor(cleannew$akpscat, 
                           levels = c(0,1, NA),
                           labels = c("Under50", "Over60", "Missing"),
                           exclude = NULL)
table(cleannew$akpscatf)

#end all esas variables that end with c - we will leave those for now.
#I often skip 0/1 factor variables that I have created for a count of something
#from treating them as proper factor variables. Only worth it if I need
#to act on them in terms of a graph or as Dv in logistic regression.


#9. Setting up date variables----
#Using lubridate transform the date variables into dmy format.
#Calculate the difference between the two assessment time points into a new variable.
class(clean$date_entry)
class(clean$date_last)

cleannew <- cleannew %>% 
  mutate(days_diff = date_last - date_entry)
cleannew$days_diff <- as.numeric(cleannew$days_diff)
psych::describe(cleannew$days_diff)


#10. Row-wise calculations----
#Using the cut variables for esas items under 6), calculate a rowwise total
#symptom score 
#for t1 and t2
cleannew <- cleannew %>%
  rowwise() %>%
  mutate(num_esast1 = sum(c(esas1_t1c, esas2_t1c, esas3_t1c,
                            esas4_t1c, esas5_t1c, esas6_t1c,
                            esas7_t1c, esas8_t1c, esas9_t1c) == 1)) %>% 
  ungroup()
View(cleannew)
#Should we use na.rm in the above call?
#t2
cleannew <- cleannew %>%
  rowwise() %>%
  mutate(num_esast2 = sum(c(esas1_t2c, esas2_t2c, esas3_t2c,
                            esas4_t2c, esas5_t2c, esas6_t2c,
                            esas7_t2c, esas8_t2c, esas9_t2c) == 1)) %>% 
  ungroup()

psych::describe(cleannew$num_esast2)

#11. Final sort and arrange----
#Sort the file by patient id.
#Do a final sweep of the file: Have you removed all interim variables that
#you do not need? Are all variables in the correct order? Is the class of
#each variable correct?

#do the final select
names(cleannew)
cleannew <- cleannew %>% 
  select(patient_id, age, age_cat, sex, sexf, weight, height, bmi, akps,
         akpscat, akpscatf, severity, date_entry, esas1_t1:esas9_t1, 
         esas1_t1c:esas9_t1c, num_esast1, date_last, esas1_t2:esas9_t2,
         esas1_t2c:esas9_t2c, days_diff)
View(cleannew)

#12. Export masterfile----
#Export the masterfile into the "data" folder.
export(cleannew, "master.rds")


#Bonus points if you start on a data dictionary.
