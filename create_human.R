# Reading the “Human development” and “Gender inequality” data sets  

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


# Looking at dimension and structure of the data sets as well as summaries of the variables
dim(hd)
str(hd)

dim(gii)
str(gii)

summary(hd)
summary(gii)

# Renaming the variables with (shorter) descriptive names (only those that have longer names)

colnames(hd)
colnames(gii)

colnames(hd)[3] <- "HDI"
colnames(hd)[5] <- "exp_years_edu"
colnames(hd)[7] <- "GNI_per_cap"
colnames(hd)[4] <- "life_exp"
colnames(hd)[6] <- "mean_years_edu"
colnames(hd)[8] <- "GNI_minus_HDI_rank"

colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "marternal_mort"
colnames(gii)[5] <- "adol_birth_rate"
colnames(gii)[6] <- "rep_in_parl"
colnames(gii)[7] <- "pop_with_sec_edu_F"
colnames(gii)[8] <- "pop_with_sec_edu_M"
colnames(gii)[9] <- "L_force_part_F"
colnames(gii)[10] <- "L_force_part_M"

 # Checking column names again after renaming
colnames(hd)
colnames(gii)

# Mutating the “Gender inequality” data and create two new variables. 
gii <- mutate(gii, F_to_M_sec_edu = pop_with_sec_edu_F / pop_with_sec_edu_M)
gii <- mutate(gii, F_to_M_l_force_part = L_force_part_F / L_force_part_M)

# Looking at summaries of the new variables
summary(gii$F_to_M_sec_edu)
summary(gii$F_to_M_l_force_part)

# Joining together the two datasets using the variable Country as the identifier
hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

# Looking at the column names of the joined data set
colnames(hd_gii)

# Dimension of the joined data set seems to be correct, namely 195 observations of 19 variables
dim(hd_gii)

# Saving the data set
library(tidyverse)
write.csv(hd_gii, "human.csv", row.names = FALSE)
