#Advanced R Workshop ALU Oct 22
#Christina Ramsenthaler
#Tidying data, #Session 0102

#Setup
.packages = c("here","rio", "tidyverse", "reshape2", "stringr", "lubridate")
# Install CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
# Load packages into session 
lapply(.packages, require, character.only=TRUE)
warnings()
options(scipen = 999)

####################################################################
## 3.1 Column headers are values, not variable names----
####################################################################
#No dataset involved to demonstrate techniques

####################################################################
## 3.2 Multiple variables stored in one column: TB dataset----
####################################################################
#Load---------------------------------------------------------------
#TB dataset
raw <- rio::import(here("data","tb.csv"), na.strings = "")
raw$new_sp <- NULL
raw <- subset(raw, year == 2000)
names(raw)[1] <- "country"

names(raw) <- str_replace(names(raw), "new_sp_", "")
raw$m04 <- NULL
raw$m514 <- NULL
raw$f04 <- NULL
raw$f514 <- NULL
View(raw)

#melt TB dataset------------------------------------------

clean <- melt(raw, id = c("country", "year"), na.rm = TRUE)
names(clean)[3] <- "column"
names(clean)[4] <- "cases"

clean <- arrange(clean, country, column, year)
View(clean)

# Break up variable in to sex and age---------------------
#library(stringr)
#str_sub extracts and replaces substrings from a character vector
#Generic usage: str_sub(string, start = 1L, end = -1L) with
#string: input character vector.
#start and end being two integer vectors. start gives position of first
#character, end gives position of the last
#Here: New variable sex that takes the first letter from col column
#as input (first letter starts and ends at 1).
clean$sex <- str_sub(clean$column, 1, 1)

#Now we split up the age groups into an age vector
#The following names the elements of the vector and gives the end
#format of the year ranges as they should appear later in the variable
#age. 
ages <- c(`04` = "0-4", 
          `514` = "5-14", 
          `014` = "0-14", 
          `1524` = "15-24", 
          `2534` = "25-34", 
          `3544` = "35-44", 
          `4554` = "45-54", 
          `5564` = "55-64", 
          `65` = "65+", 
          u = NA)

#Here, we extract the age groups from the original columns and use the
#named vector ages to pass the categories as factor levels. We store this
#information into the age column in the clean dataset.
clean$age <- factor(ages[str_sub(clean$column, 2)], levels = ages)
class(clean$age)
levels(clean$age)

#Reorder the dataset and drop column
clean <- clean[c("country", "year", "sex", "age", "cases")]
View(clean)

####################################################################
## 3.3 Variables are stored in both rows and columns: weather dataset----
####################################################################

raw <- read.csv2(here("data","weather.csv"), header = TRUE)
names(raw)[1] <- "id"
View(raw)

# Melt and tidy----------------------------------------------------------
clean1 <- melt(raw, id = 1:4, na.rm = TRUE)
#Clean day by using str_replace function from string_r
#Replaces pattern "d" with nothing "" (so essentially deletes the leading d)
#Then the variable is put as integer.
clean1$day <- as.integer(str_replace(clean1$variable, "d", ""))
#Using ISOdate function
clean1$date <- as.Date(ISOdate(clean1$year, clean1$month, clean1$day))

#Reorder variables in dataset
clean1 <- clean1[c("id", "date", "element", "value")]
#Sort variables in dataset
clean1 <- arrange(clean1, date, element)
View(clean1)

# Cast (make two variables)---------------------------------------------
clean2 <- dcast(clean1, ... ~ element)
View(clean2)

####################################################################
## 3.4 Multiple types in one table: Billboard dataset----
####################################################################

raw <- read.csv(here("data","billboard.csv"), header = TRUE)
View(raw)

#Indexing and ordering my col name
raw <- raw[, c("year", "artist.inverted", "track", "time", "date.entered", "x1st.week", 
               "x2nd.week", "x3rd.week", "x4th.week", "x5th.week", "x6th.week", "x7th.week", 
               "x8th.week", "x9th.week", "x10th.week", "x11th.week", "x12th.week", "x13th.week", 
               "x14th.week", "x15th.week", "x16th.week", "x17th.week", "x18th.week", "x19th.week", 
               "x20th.week", "x21st.week", "x22nd.week", "x23rd.week", "x24th.week", "x25th.week", 
               "x26th.week", "x27th.week", "x28th.week", "x29th.week", "x30th.week", "x31st.week", 
               "x32nd.week", "x33rd.week", "x34th.week", "x35th.week", "x36th.week", "x37th.week", 
               "x38th.week", "x39th.week", "x40th.week", "x41st.week", "x42nd.week", "x43rd.week", 
               "x44th.week", "x45th.week", "x46th.week", "x47th.week", "x48th.week", "x49th.week", 
               "x50th.week", "x51st.week", "x52nd.week", "x53rd.week", "x54th.week", "x55th.week", 
               "x56th.week", "x57th.week", "x58th.week", "x59th.week", "x60th.week", "x61st.week", 
               "x62nd.week", "x63rd.week", "x64th.week", "x65th.week", "x66th.week", "x67th.week", 
               "x68th.week", "x69th.week", "x70th.week", "x71st.week", "x72nd.week", "x73rd.week", 
               "x74th.week", "x75th.week", "x76th.week")]
#renaming the second col in dataset
names(raw)[2] <- "artist"

#Base::iconv is a function that converts between different character 
#encodings. Here we convert from MAC to ASCII.
raw$artist <- iconv(raw$artist, "MAC", "ASCII//translit")
#Working with regular expressions and escape characters \\ \\ to extract
#and replace dots in the track names 
raw$track <- str_replace(raw$track, " \\(.*?\\)", "")
#str_c from stringr package joins 2 ore more vectors element-wise into 
#a single character vector. We use this to rename the columns containing
#the weekly ranks in the dataset. We overwrite all these columns with the
#pattern wk and number from 1 to 76.
names(raw)[-(1:5)] <- str_c("wk", 1:76)
View(raw)
#Now we order our data in all columns of raw, here we sort by year, 
#then artist, then track
raw <- arrange(raw, year, artist, track)

#Here we abolish long song names in the track column and give them
#an abbreviation of "..." if they are longer than 20 characters.
#We use the concept of storing the condition in a vector to use
#conditional/logical subsetting.
#The nchar() function counts the number of characters in a string.
long_name <- nchar(raw$track) > 20
raw$track[long_name] <- paste0(substr(raw$track[long_name], 0, 20), "...")

#Now we melt to get to a tidy dataset that gives the weeks as one variable.
clean <- melt(raw, id = 1:5, na.rm = TRUE)
#We want to create a clean column week which has the week number as an
#integer variable.
#str_replace_all follows the pattern of finding a string, giving the 
#pattern, replacing the pattern.
#Given in "[^0-9]+" is a regular expression. See list of patterns here:
#https://regenerativetoday.com/a-beginners-guide-to-match-any-pattern-using-regular-expressions-in-r/
clean$week <- as.integer(str_replace_all(clean$variable, "[^0-9]+", ""))
#This gets rid off the old week variable.
clean$variable <- NULL

#Now we work with lubridate to transform the date variable into a real date
#variable
class(clean$date.entered)
#library(lubridate)
clean$date.entered <- ymd(clean$date.entered)
class(clean$date.entered)
clean$date <- clean$date.entered + weeks(clean$week - 1)
#Get rid off old variable
clean$date.entered <- NULL
#Rename value col as rank col
names(clean)[names(clean) == "value"] <- "rank"
#alternative way via dplyr: rename (new name = old name)
#clean <- clean %>% 
#  rename(
#    rank = value
#  )
#reorder dataset
clean <- arrange(clean, year, artist, track, time, week)
#rearrange columns
clean <- clean[c("year", "artist", "time", "track", "date", "week", "rank")]
View(clean)

# Normalization --------------------------------------------------------------
library(plyr)
#Using the unique function to find single instances of artists, track and
#time.
#unrowname is a plyr function to strip rownames from an object
song <- unrowname(unique(clean[c("artist", "track", "time")]))
#making a new id variable that starts at 1 and end at total numbers of
#rows in df song.
song$id <- 1:nrow(song)

#Saving the first 15 rows with certain order of cols
narrow <- song[1:15, c("id", "artist", "track", "time")]
View(narrow)

#Saving the rank information into its own dataset via plyr::join
#plyr::join is an implementation of SQL joins. 
#Usage: join(x, y, by = NULL, type = "left", match = "all")
#4 join types are inner, left, right, full -> see 
?plyr::join
#Here, we join the clean dataset with the song dataset to get a common
#id variable.
rank <- join(clean, song, match = "first")
#Now we can narrow the rank dataset and just keep id information, date and rank
#We would later be able to join back to clean by joining via id.
rank <- rank[c("id", "date", "rank")]
#Putting the date variable back into character
rank$date <- as.character(rank$date)
View(rank)

####################################################################
## 3.5 One type in multiple tables----
####################################################################

#Code below not run
#See full example under https://github.com/hadley/data-baby-names

paths <- dir("data", pattern = "\\.csv$", full.names = TRUE)
names(paths) <- basename(paths)
ldply(paths, read.csv, stringsAsFactors = FALSE)



