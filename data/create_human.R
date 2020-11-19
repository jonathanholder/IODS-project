# 1 ok
# 2: reading data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# metadata: http://hdr.undp.org/en/content/human-development-index-hdi, 
# 3: data overview

dim(hd)
str(hd)
summary(hd)

dim(gii)
str(gii)
summary(gii)

# both with 195 rows/observations/countries, should match; otherwise no overlap


# 4: usable variable names
names(hd)
names(hd) <- c("hdi_rank", "country", "hdi", "life_exp", "edu_exp", "edu_now", "gni_cpta", "gni_hdi_rank")

names(gii)
names(gii) <- c("gii_rank", "country", "gii", "mat_mort", "adol_birth", "rep_parl", "secedu_f", "secedu_m", "lab_f", "lab_m")

#5: add female ratio variables for secondary education and labour participation 

gii$secedu_f.ratio <- round(gii$secedu_f/gii$secedu_m, 4)
gii$lab_f.ratio <- round(gii$lab_f/gii$lab_m, 4)


#6 merge/join & save

human <- merge(gii, hd, by="country", all=F)
dim(human)
head(human)

write.csv(human, file="data/human.csv", row.names=F)
  
