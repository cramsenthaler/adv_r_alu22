################################################################
#                 Exercise 1: Data cleaning                    #
################################################################

write.csv2(Patient_1_final_with_German_cleaned, "spss.csv")

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

#1. Raw file data import----
#You might have to do someting when you read in the data.


#2. Cleaning column names----
#Definitely look at date variables
#Also recode the 10 symptoms such that they read esas01 to esas10


#3. Dealing with structural problems----
#Decide whether you want to keep this in wide format (I would for now).
#Think about what you can and cannot do in wide format.
#For the brave: Read through the pivoting chapter https://www.epirhandbook.com/en/pivoting-data.html
#and try a pivoted version. You will then calculate the date difference 
#between time points in a different way (grouped data).

#4. Selecting or re-ordering columns----
#Reorder columns so that patient characteristics are at the beginning.
#Have all data belonging to a time point consecutively arranged.

#5. Deduplication----
#Check whether there are duplicated cases.


#6. Column creation or transformation----
#Calculate the bmi for each patient in the file.
#Check column classes and transform wrong column classes.
#Recode each esas symptom variable such that this is yes for values >= 5
#and no for values <5.


#7. Re-coding variables----
#Calculate age categories using quantile breaks
#Recode performance status akps with a cutoff of <= 50 for low performance status.
#Check for Missing values and code all '999' as NA.

#8. Setting up factor variables----
#Recode factor variables with factor levels.
#Also give recoded variables under 7) the proper factor levels.

#9. Setting up date variables----
#Using lubridate transform the date variables into dmy format.
#Calculate the difference between the two assessment time points into a new variable.

#10. Row-wise calculations----
#Using the cut variables for esas items under 6), calculate a rowwise total
#symptom score 

#11. Final sort and arrange----
#Sort the file by patient id.
#Do a final sweep of the file: Have you removed all interim variables that
#you do not need? Are all variables in the correct order? Is the class of
#each variable correct?

#12. Export masterfile----
#Export the masterfile into the "data" folder.

#Bonus points if you start on a data dictionary.
