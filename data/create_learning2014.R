# IODS Exercise 2: data wrangling
# 2020-11-02
# Jonathan Holder
# preparing learning survey dataset for further analysis

#### 1: ok ####

#### 2 ####
l14raw<- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=T)
dim(l14raw)
# --> 183 rows (probably students/subjects/observations), 60 columns (probably variables)
str(l14raw)
# --> first 56 columns: values ranging between 1 and 5, colnames some sort of code (questions?)
# --> columns 57 to 60:  Age, Attitude, Points, and gender, respectively


#### 3 ####

# load dplyr
library(dplyr)

## copy/paste from datacamp, rename l14raw

lrn14 <- l14raw

# remove points=0
lrn14 <- lrn14[lrn14$Points!=0,]
# check number of observations (instructions: should be 166)
nrow(lrn14) #ok

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# new data frame with age, attitude, points, gender only 

lrn14.s <- lrn14[,57:60]

# adding combination variables to thois ne data frame

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14.s$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14.s$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14.s$stra <- rowMeans(strategic_columns)

dim(lrn14.s) # ok, corresponds to instructions


#### 4 ####

# setting working directory
wd <- "/Volumes/onedrive/OneDrive\ -\ University\ of\ Helsinki/courses/ods/IODS-project"
setwd(wd)
getwd() # ok

# saving lrn14.s
write.csv(lrn14.s, "data/learning2014.csv", row.names = F)
# note: as a default, row names (numbers) will be added as a new column
# to prevent that: set row.names=F

# re-reading

learning2014<- read.csv("data/learning2014.csv")
str(learning2014)
head(learning2014)
dim(learning2014)
# looks ok


