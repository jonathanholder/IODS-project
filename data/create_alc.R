# IODS Exercise 3: data wrangling
# 2020-11-09
# Jonathan Holder
# preparing learning portuguese alcohol consumption dataset for further analysis

library(dplyr)


####  3 #### 

por <- read.csv("data/student-por.csv", sep=";")
mat <- read.csv("data/student-mat.csv", sep=";")

dim(por)
str(por)

dim(mat)
str(mat)


#### 4 #### 

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers

math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

dim(math_por)
str(math_por)


#### 5 #### 

alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
head(alc)


#### 6 ####

alc$alc_use <- (alc$Dalc + alc$Walc)/2
alc$high_use <- alc$alc_use>2

alc$alc_use


#### 7 ###

glimpse(alc)
dim(alc) # seems ok
write.csv(alc, "data/alc.csv")


alc_check <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt", sep=",", header=T)

head(alc_check)
head(alc)
nrow(alc)
nrow(alc_check)


