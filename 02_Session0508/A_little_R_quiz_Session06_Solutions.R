####################################################
#            Session 6: A little R quiz            #
####################################################

#Setup-----
#This quiz presents exercises to directly compare base R and dplyr syntax.

#Please install the package fueleconomy from Github. We will work with its
#dataset vehicles. Get a feeling what's in this dataset. Hint: use glimpse()
#from dplyr package and skim (from skimr package).
# Install and load the "fueleconomy" package
# install.packages("devtools")
#devtools::install_github("hadley/fueleconomy")
#library(fueleconomy)

# Install and load the "dplyr" library (part of tidyverse)
#install.packages("dplyr")
#library(dplyr)
skimr::skim(vehicles)
glimpse(vehicles)
View(vehicles)

#1. Exercise 1----
# Select the different manufacturers (makes) of the cars in this data set.
# Save this vector in a variable
makes <- vehicles$make
#Find the corresponding dplyr syntax.
makes <- select(vehicles, make)

#2. Exercise 2-----
# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
length(unique(makes$make))
#Now find the corresponding dplyr way of doing this.

#This needs the `distinct()` function. 
#The equivalent to length in base R is nrow in dplyr.
nrow(distinct(vehicles, make))

#3. Exercise 3----
# Filter the data set for vehicles manufactured in 1997
#Base R:
cars_1997 <- vehicles[vehicles$year == 1997, ]
#How can we accomplish this in dplyr?
#Any sort of subsetting or logical indexing is represented by the filter() verb.
cars_1997 <- filter(vehicles, year == 1997)

#4. Exercise 4----
#Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
cars_1997 <- cars_1997[order(cars_1997$hwy), ]

#How do we do this in dplyr?
cars_1997 <- arrange(cars_1997, hwy)

#5. Exercise 5----
# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
#In base R:
cars_1997$average <- (cars_1997$hwy + cars_1997$cty) / 2

#How can we do this in dplyr?
cars_1997 <- mutate(cars_1997, average = (hwy + cty) / 2)

#6. Exercise 6----
# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city.
# Save this new data frame in a variable.
two_wheel_20_mpg <- vehicles[vehicles$drive == "2-Wheel Drive" & vehicles$cty > 20, ]

#How can we do this in dplyr?
two_wheel_20_mpg <- filter(vehicles, drive == "2-Wheel Drive", cty > 20)

#7. Exercise 7----
# Of the above vehicles, what is the vehicle ID of the vehicle with the worst
# hwy mpg (highway miles per gallon)?
# Hint: filter for the worst vehicle, then select its ID.
worst_hwy <- two_wheel_20_mpg$id[two_wheel_20_mpg$hwy == min(two_wheel_20_mpg$hwy)]

#How can we do this in dplyr?
filtered <- filter(two_wheel_20_mpg, hwy == min(hwy))
worst_hwy <- select(filtered, id)

#8. Exercise 8----
#Don't do if short for time.
# Write a function that takes a `year_choice` and a `make_choice` as parameters,
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles
# of that make in that year.
# You'll need to filter more (and do some selecting)!
make_year_filter <- function(make_choice, year_choice) {
  filtered <- vehicles[vehicles$make == make_choice & vehicles$year == year_choice, ]
  filtered[filtered$hwy == max(filtered$hwy), "model"]
}

#How can we do this with dplyr filter and select functions?
make_year_filter <- function(make_choice, year_choice) {
  filtered <- filter(vehicles, make == make_choice, year == year_choice)
  filtered <- filter(filtered, hwy == max(hwy))
  selected <- select(filtered, model)
  selected
}

#9. Exercise 9----
# Using the new function: What was the most efficient Honda model of 1995?
make_year_filter("Honda", 1995)
