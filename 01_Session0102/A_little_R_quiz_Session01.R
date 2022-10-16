####################################################
#            Session 1: A little R quiz            #
####################################################

#What is the square root of 2 taken to the 2nd power?

#How can you store this value in an object?

#How can you test whether the square root of 3 does not equal
#the cosinus of 17

#What does p = 2.533e-07 and how do you get rid of this?
#0.00000002533

#Create a vector `names` that contains your name and the names 
#of 2 people in the room. Print the vector. What needs to change that
#it prints directly into the console?

#Create a vector with numbers 10 to 49.

#How many elements does this vector have?

#Add 1 to each element in elements and print the result.

#Create a vector 'm' that contains the numbers 10 to 1.

#Subtract 'm' from 'elements'. What is happening?

#Produce a range of numbers from -5 to 10 in 0.1 increments. 
#Store it in a variable `x_range`.

#What is the generic form of the sequence function? How can you run 
#examples from the documentation?

#General help: https://www.r-project.org/help.html

#How can you form the following vector?
#[1] 3 3 5 5 9 9 3 3 5 5 9 9 3 3 5 5 9 9

#Create a vector `even` that holds the even numbers from 1 to 100. 
#Start at number 2 as first even number.

#Using the all() function and %% (modulo) operator, confirm that all 
#of the numbers in your `even` vector are even.

#Create a vector `phone_numbers` that contains the 
#numbers 8, 6, 7, 5, 3, 0, 9

#Create a vector `prefix` that has the first three elements 
#of `phone_numbers`.

#Create a vector `small` that has the values of `phone_numbers` that are 
#less than or equal to 5.

#Create a vector `large` that has the values of `phone_numbers` that are 
#strictly greater than 5

#Replace the values in `phone_numbers` that are larger than 5 
#with the number 5.

#Replace every odd-numbered value in `phone_numbers` with the number 0

#Create a vector `my_breakfast` of everything you ate for breakfast

#Create a vector `my_lunch` of everything you will eat for lunch

#Create a list `meals` that contains your breakfast and lunch

#Add a "dinner" element to your `meals` list that has what you plan 
#to eat for dinner

#Use dollar notation to extract your `dinner` element from your list
#and save it in a vector called 'dinner'

#Use double-bracket notation to extract your `lunch` element from 
#your list and save it in your list as the element at index 5 
#(no reason beyond practice).

# Use single-bracket notation to extract your breakfast and 
#lunch from your list and save them to a list called `early_meals`

#Name the 5th element in your list meals as 'lunch'.

###Challenge!###
#Create a list that has the number of items you ate for each meal
#Hint: use the `lappy()` function to apply the `length()` function 
#to each item.

#What is the generic form to write a function?

#What are the four 'rules' for writing functions?

#Create a function to compute the standard error (of the mean)
#using the 4 'rules'.
#Use temporary values tmp.sd to hold the sd, tmp.N to hold the sample
#size, use tmp.se to calculate the SE as SD/sqrt(N), and 
#use return for returning the SE.

#Let's test this on a vector with values 1:5.

#Write a function `add_pizza` that adds pizza to a given meal vector, 
#and returns the pizza-fied vector

#Create a vector `better_meals` that is all your meals, but with pizza!

#Create a *list* of 10 random numbers. Use the `runif()` function to 
#make a vector of random numbers, then use `as.list()` to convert that 
#to a list.

#Use `lapply()` to apply the `round()` function to each number, 
#rounding it to the nearest 0.1 (one decimal place)

#What is the difference between lapply() and sapply()?

#Matrix
#What is the generic R function for creating a matrix?

#What does byrow = FALSE result in? What happens here?

#What then happens when we run the following?

#For the matrix age, calculate the sum for each row.

#For the matrix age, calculate the sum for each row via apply.

#Create a matrix object m with numbers 1:12 with 3 cols and 4 rows, 
#give the rows the names r1, r2, r3 and r4, and the cols the names
#c1, c2, c3.

#Change the number of the 2nd row, 3rd column in matrix m to 13.

#Change the numbers of the 2nd row in matrix m to the values 10,20,30 via
#indexing using the row name.

##Working with data frames
set.seed(1234)
#Create a vector of 100 employees ("Employee 1", "Employee 2", ... 
#"Employee 100"). 
#Hint: use the `paste()` function and vector recycling to add a number to the 
#word "Employee".

#Create a vector of 100 random salaries for the year 2017.
#Use the `runif()` function to pick random numbers between 40000 and 50000

#Create a vector of 100 annual salary adjustments between -5000 and 10000.
#(A negative number represents a salary decrease due to corporate greed)
#Again use the `runif()` function to pick 100 random numbers in that range.

#Create a data frame `salaries` by combining the 3 vectors you just made

#What is the class of each column in the data frame?

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).

#Add a column to the `salaries` data frame that has a value of `TRUE` 
#if the person got a raise (their salary went up).

#What was the 2018 salary of Employee 57?

#How many employees got a raise?

#What was the monetary value of the highest raise?

#What was the "name" of the employee who received the highest raise?

#What was the largest decrease in salaries between the two years?

#What was the name of the employee who recieved largest decrease in salary?

#What was the average salary change?

#For people who did not get a raise, how much money did they 
#lose on average?

#Write a .csv file of your salary data to your working directory

#List all the objects in your working directory.

#Clear all the objects from your working directory.
