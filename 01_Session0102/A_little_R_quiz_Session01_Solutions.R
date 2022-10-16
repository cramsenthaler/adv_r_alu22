####################################################
#            Session 1: A little R quiz            #
####################################################

#What is the square root of 2 taken to the 2nd power?
sqrt(2)^2

#How can you store this value in an object?
object1 <- sqrt(2)^2

#How can you test whether the square root of 3 does not equal
#the cosinus of 17
sqrt(3) != cos(17)

#What does p = 2.533e-07 and how do you get rid of this?
#0.00000002533
options(scipen = 999)

#Create a vector `names` that contains your name and the names 
#of 2 people in the room. Print the vector. What needs to change that
#it prints directly into the console?
names <- c("Joel", "Mike", "Dave")
print(names)
names
(names <- c("Joel", "Mike", "Dave"))

#Create a vector with numbers 10 to 49.
elements <- 10:49

#How many elements does this vector have?
length(elements)

#Add 1 to each element in elements and print the result.
print(elements + 1)
elements + 1
elements2 <- elements + 1

#Create a vector 'm' that contains the numbers 10 to 1.
m <- seq(10, 1)

#Subtract 'm' from 'elements'. What is happening?
(element_sub <- elements - m)
print(element_sub)
length(elements)
length(m)
#Vector recycling is happening.

#Produce a range of numbers from -5 to 10 in 0.1 increments. 
#Store it in a variable `x_range`.
(x_range <- seq(-5, 10, 0.1))

#What is the generic form of the sequence function? How can you run 
#examples from the documentation?
?seq
example(seq)
#General help: https://www.r-project.org/help.html

#How can you form the following vector?
#[1] 3 3 5 5 9 9 3 3 5 5 9 9 3 3 5 5 9 9
rep(x=c(3,5,9), times = 3, each = 2)

#Create a vector `even` that holds the even numbers from 1 to 100. 
#Start at number 2 as first even number.
even <- seq(2, 100, 2)

#Using the all() function and %% (modulo) operator, confirm that all 
#of the numbers in your `even` vector are even.
(test <- all(even %% 2 == 0))

#Create a vector `phone_numbers` that contains the 
#numbers 8, 6, 7, 5, 3, 0, 9
phone_numbers <- c(8, 6, 7, 5, 3, 0, 9)

#Create a vector `prefix` that has the first three elements 
#of `phone_numbers`.
prefix <- phone_numbers[1:3]

#Create a vector `small` that has the values of `phone_numbers` that are 
#less than or equal to 5.
small <- phone_numbers[phone_numbers <= 5]

#Create a vector `large` that has the values of `phone_numbers` that are 
#strictly greater than 5
large <- phone_numbers[phone_numbers > 5]

#Replace the values in `phone_numbers` that are larger than 5 
#with the number 5.
phone_numbers[phone_numbers > 5] <- 5
print(phone_numbers)

#Replace every odd-numbered value in `phone_numbers` with the number 0
phone_numbers[phone_numbers %% 2 == 1] <- 0
print(phone_numbers)

#Create a vector `my_breakfast` of everything you ate for breakfast
my_breakfast <- c("toast", "eggs", "tea")

#Create a vector `my_lunch` of everything you will eat for lunch
my_lunch <- c("soup", "falafel")

#Create a list `meals` that contains your breakfast and lunch
meals <- list(breakfast = my_breakfast, lunch = my_lunch)

#Add a "dinner" element to your `meals` list that has what you plan 
#to eat for dinner
meals$dinner <- c("veg", "rice")

#Use dollar notation to extract your `dinner` element from your list
#and save it in a vector called 'dinner'
dinner <- meals$dinner

#Use double-bracket notation to extract your `lunch` element from 
#your list and save it in your list as the element at index 5 
#(no reason beyond practice).
meals[[5]] <- meals[["lunch"]]
meals

# Use single-bracket notation to extract your breakfast and 
#lunch from your list and save them to a list called `early_meals`
early_meals <- meals[1:2]
early_meals

#Name the 5th element in your list meals as 'lunch'.
names(meals)[[5]] <- "lunch" 
meals

###Challenge!###
#Create a list that has the number of items you ate for each meal
#Hint: use the `lappy()` function to apply the `length()` function 
#to each item.
items <- lapply(meals, length)

#What is the generic form to write a function?
functionname <- function(Inputs) { Expr }

#What are the four 'rules' for writing functions?
#1 Put { } around arguments/expression (even if it's on 1 line)
#2 Use temporary values to hold results of the function
#3 Comment
#4 Use keyword return() to explicitly show the value that the function returns.

#Create a function to compute the standard error (of the mean)
#using the 4 'rules'.
#Use temporary values tmp.sd to hold the sd, tmp.N to hold the sample
#size, use tmp.se to calculate the SE as SD/sqrt(N), and 
#use return for returning the SE.
se_new <- function(x) {
  #computes standard error of the mean
  tmp.sd <- sd(x) #standard deviation of an object x
  tmp.N <- length(x) #sample size
  tmp.se <- tmp.sd/sqrt(tmp.N) #std error of the mean
  return(tmp.se)
}
#Let's test this on a vector with values 1:5.
testvector <- 1:5
se_new(testvector)

#Write a function `add_pizza` that adds pizza to a given meal vector, 
#and returns the pizza-fied vector
add_pizza <- function(meal) {
  meal <- c(meal, "pizza")
  meal # return the new vector
}

#Create a vector `better_meals` that is all your meals, but with pizza!
better_meals <- lapply(meals, add_pizza)

#Create a *list* of 10 random numbers. Use the `runif()` function to 
#make a vector of random numbers, then use `as.list()` to convert that 
#to a list.
nums <- as.list(runif(10, 1, 100))

#Use `lapply()` to apply the `round()` function to each number, 
#rounding it to the nearest 0.1 (one decimal place)
lapply(nums, round, 1)

#What is the difference between lapply() and sapply()?
#lapply() is a generic function to apply a function over a list or vector.
#sapply() is a user-friendly version of apply by default returning a vector (or matrix).

#Matrix
#What is the generic R function for creating a matrix?
matrix(data, nrow = 1, ncol = 1, byrow = FALSE)
#What does byrow = FALSE result in? What happens here?
matrix(1:10, ncol=5)
#A 2 rows x 5 cols matrix with numbers 1 to 10 is created,
#the numbers are filled in columnwise.

#What then happens when we run the following?
(age <- matrix(c(29,26,58,53,61,54), 2, 3, TRUE))

#For the matrix age, calculate the sum for each row.
rowSums(age)

#For the matrix age, calculate the sum for each row via apply.
apply(age, 1, sum)

#Create a matrix object m with numbers 1:12 with 3 cols and 4 rows, 
#give the rows the names r1, r2, r3 and r4, and the cols the names
#c1, c2, c3.
m <- matrix(data=1:12, nrow=4, ncol=3,
            dimnames=list(c("r1","r2","r3","r4"),
                          c("c1","c2","c3")))
m

#Change the number of the 2nd row, 3rd column in matrix m to 13.
m[2,3] <- 13
m

#Change the numbers of the 2nd row in matrix m to the values 10,20,30 via
#indexing using the row name.
m["r2",] <- c(10,20,30)
m

##Working with data frames
set.seed(1234)
#Create a vector of 100 employees ("Employee 1", "Employee 2", ... 
#"Employee 100"). 
#Hint: use the `paste()` function and vector recycling to add a number to the 
#word "Employee".
employees <- paste("Employee", 1:100)

#Create a vector of 100 random salaries for the year 2017.
#Use the `runif()` function to pick random numbers between 40000 and 50000
salaries_2017 <- runif(100, 40000, 50000)

#Create a vector of 100 annual salary adjustments between -5000 and 10000.
#(A negative number represents a salary decrease due to corporate greed)
#Again use the `runif()` function to pick 100 random numbers in that range.
salary_adjustments <- runif(100, -5000, 10000)

#Create a data frame `salaries` by combining the 3 vectors you just made
salaries <- data.frame(employees, 
                       salaries_2017, 
                       salary_adjustments, stringsAsFactors = FALSE)

#What is the class of each column in the data frame?
str(salaries)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
salaries$salaries_2018 <- salaries$salaries_2017 + salaries$salary_adjustments

#Add a column to the `salaries` data frame that has a value of `TRUE` 
#if the person got a raise (their salary went up).
salaries$got_raise <- salaries$salaries_2018 > salaries$salaries_2017

#What was the 2018 salary of Employee 57?
salaries[salaries$employees == "Employee 57", "salaries_2018"]

#How many employees got a raise?
nrow(salaries[salaries$got_raise == TRUE, ])

#What was the monetary value of the highest raise?
(highest_raise <- max(salaries$salary_adjustments))

#What was the "name" of the employee who received the highest raise?
salaries[salaries$salary_adjustments == highest_raise, "employees"]

#What was the largest decrease in salaries between the two years?
biggest_paycut <- min(salaries$salary_adjustments)

#What was the name of the employee who recieved largest decrease in salary?
got_biggest_paycut <- salaries[salaries$salary_adjustments == biggest_paycut, "employees"]

#What was the average salary change?
avg_increase <- mean(salaries$salary_adjustments)

#For people who did not get a raise, how much money did they 
#lose on average?
avg_loss <- mean(salaries$salary_adjustments[salaries$got_raise == FALSE])

#Write a .csv file of your salary data to your working directory
write.csv2(salaries, "salaries.csv")

#List all the objects in your working directory.
ls()

#Clear all the objects from your working directory.
rm(list = ls())
