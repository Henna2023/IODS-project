"Henna Karhapaa"
date()
"Assignment 2 - Data Wrangling"

# Read the data file
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = T)

# Explore the dimensions
dim(learning2014)
# output shows that there are 183 observations of 60 variables

# Explore the structure
str(learning2014)
# output displays the structure of the data set

# Create a dataset with gender, age, attitude, deep, stra, surf and points
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(learning2014, one_of(deep_questions))
# and create column 'deep' by averaging
learning2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(learning2014, one_of(surface_questions))
# and create column 'surf' by averaging
learning2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(learning2014, one_of(strategic_questions))
# and create column 'stra' by averaging
learning2014$stra <- rowMeans(strategic_columns)

# Exclude observations where exam points that are zero
learning2014 <- filter(learning2014, Points != 0)

# Select only gender, age, attitude, deep, surface, strategy
learning2014 <- learning2014[, c("gender","Age","Attitude", "deep", "stra", "surf", "Points")]


# Check dimensions - output 166 7
dim(learning2014)

# Set-up the working directory dataset (check current wd)
getwd()
# Working directory is IODS-project

# Save dataset to working directory
write.csv(learning2014, "learning2014.csv", row.names = FALSE)


# Read saved dataset
learning2014 <- read.csv("learning2014.csv", sep = ",", header = TRUE)

# Check dimensions
dim(learning2014)
str(learning2014)

# Dimensions of data file 166 obs of 7 variables and structure of data looks as it should
