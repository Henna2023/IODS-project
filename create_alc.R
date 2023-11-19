"Henna Karhapaa"
date()
"Assignment 3 - Data Wrangling"

# Read the data file
mat <- read.table("C:/Users/henna/Desktop/IODS-project/studentmat.csv", sep = ";", header = T)
por <- read.table("C:/Users/henna/Desktop/IODS-project/studentpor.csv", sep = ";", header = T)

# Looking at dimension and structure of datasets

dim(mat)
str(mat)

# mat has 395 observations of 33 variables 

dim(por)
str(por)

# por has 649 observations of 33 variables 

# look at the column names of both data sets
colnames(mat); colnames(por)

library(dplyr)

# Columns that vary in the two data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")

# Columns used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# Joining the two data sets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))

# look at the column names of the joined data set
colnames(mat_por)

# glimpse at the joined data set
glimpse(mat_por)

# Data frame for only the joined columns
joined <- select(mat_por, all_of(join_cols))

# Keeping only the students present in both data sets
for(col_name in free_cols) {
  two_cols <- select(mat_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    joined[col_name] <- round(rowMeans(two_cols))
  } else {
    joined[col_name] <- first_col
  }
}

# Looking at structure and dimension of the joined data set without duplicates
str(joined)
dim(joined)


# A new column alc_use by combining weekday and weekend alcohol use
joined <- mutate(joined, alc_use = (Dalc + Walc) / 2)

# A new logical column for 'high_use'
joined <- mutate(joined, high_use = alc_use > 2)

# Glimpse at joined data set
glimpse(joined)
dim(joined)


# Saving the joined data set to the ‘data’ folder

library(tidyverse)

# Save dataset to working directory
write.csv(joined, "joined.csv", row.names = FALSE)


# Read saved dataset
joined <- read.csv("joined.csv", sep = ",", header = TRUE)

# Check dimensions
dim(joined)
str(joined)

# 370 observations of 35 variables