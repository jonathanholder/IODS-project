# data wrangling, exercise 6: BPRS and RATS
# jonathan holder
# 2020-11-30

library(tidyverse)

# 1: reading data 
bp <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=T)

str(bp)
summary(bp)

# 40 rows corresponding to individuals
# col treatment divides individuals into two categories, col subject: 2 x identifier 1-20 (for each treatment)
# weekX columns: 9 repeated measurements of the same variable
head(rats)
str(rats)
summary(rats)

# 16 rows corresponding to individuals
# col group divides individuals into three categories, col ID: identifier 1-16 (spanning all three groups)
# WDXX columns: 11 repeated measurements of the same variable (note: intervals not constant!)


# 2: factorising
rats$ID <- as.factor(rats$ID)
rats$Group <- as.factor(rats$Group)

bp$treatment <- as.factor(bp$treatment)
bp$subject <- as.factor(bp$subject)

# 3: convert to long format

rats.l <- gather(rats, key=time, value=weight, -ID, -Group)
rats.l <-  mutate(rats.l, time = as.integer(substr(time, 3, length(time))))

head(rats.l)

bp.l <- gather(bp, key=week, value=bprs, -subject, -treatment)
bp.l <-  mutate(bp.l, week = as.integer(substr(week, 5, 5)))

head(bp.l)

# 4: 'serious' look at datasets

str(rats.l)
summary(rats.l)
head(rats.l)

str(bp.l)
summary(bp.l)
head(bp.l)

# The main idea of the long format is to have a row for each observation/value, where all 'background' information (time of measurement, individual, and group), is explicitely specified within the row (i.e. represented by columns for each of these variables)
# conversely, in the wide format, rows correspond to individuals, and one row includes all values/observations of this individual (and addtitional background information, here group) 


write.csv(rats.l, file="data/rats.l.csv")
write.csv(bp.l, file="data/bprs.l.csv")


