# data wrangling with human indices, pt2
# jonathan holder
# 2020-11-23
#
# original data sources:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv
# pre-processed in 
# https://github.com/jonathanholder/IODS-project/blob/master/data/create_human.R


library("tidyverse")

# 0
human <- read.csv("data/human.csv")
dim(human)
str(human)
# country- and region-wise data on a variety of human development and gender inequality variables; variable names changed from lengthy original ones to more typing/R-friendly versions (should be self-explanatory when compared to metadata, I don't think listing those is the point here). 195 countries/regions, 20 variables (¡note: some calculated from others!)

# 1
human$gni_cpta.n <- as.numeric(str_replace(human$gni_cpta, pattern=",", replace = ""))

# 2
names(human)
# subset, get colnames from above
human2 <- subset(human, select=c("country", "secedu_f.ratio", "edu_exp", "life_exp", "lab_f.ratio", "mat_mort", "gni_cpta.n", "adol_birth", "rep_parl"))

# 3
dim(human2)
# new column with rowcount of NAs (for all cols but county)
human2$nas<- rowSums(is.na(human2[2:9]))
# subset rows without NAs
human3 <- human2[human2$nas<1,]
human3$nas <- NULL
nrow(human3)
nrow(human2)

# 4 
# regions at one place in metadata (everything summarised except non-latin america, isn't that a little openly US-centred for the UN??)
# http://hdr.undp.org/en/content/human-development-index-hdi
regions<- c("Arab States",
"East Asia and the Pacific",
"Europe and Central Asia",
"Latin America and the Caribbean",
"South Asia",
"Sub-Saharan Africa",
"World")

# apparently, the opposite of %in% doesn't exist in base R --> 
'%!in%' <- function(x,y)!('%in%'(x,y))

human4 <- human3[human3$country%!in%regions,]


# 5
rownames(human4) <- human4$country
human4$country <- NULL
dim(human4) # ok, as in instructions

# not a friend of overwriting input with output, so
write.csv(human4, "data/human2.csv", row.names = T)


