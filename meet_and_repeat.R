"Assignment 6 - Data Wrangling"

# Read the data files
BPRS  <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = T)

write.csv(BPRS, "BPRS.csv", row.names = FALSE)
write.csv(RATS, "RATS.csv", row.names = FALSE)

# Both BPRS and RATS data sets include repeated measures data where a response variable is recorded several times over some period of time. Thus, these represent longitudinal data sets.

# BPRS includes data for 40 male subjects that were randomly assigned to one of two treatment groups and each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals for eight weeks. 
# Data assesses the level of 18 symptom constructs rated from one (not present) to seven (extremely severe). The study is focus on presence of schizophrenia.

# Looking at dimension, summary and structure of the BPRS data set
dim(BPRS)
str(BPRS)
names(BPRS)
glimpse(BPRS)
summary(BPRS)

# BPRS data set includes 40 observations of 11 variables. 
# - Treatment variable indicates assignment to one of two treatment groups
# - Subject refers to the male subjects that are studied. There are 20 subjects in each treatment group.
# - Rest of the variables include BPRS assessments measured each week for 8 weeks with week0 indicating the baseline.

# RATS includes data from a nutrition study conducted in three groups of rats. The three groups were put on different diets. 
# Each rat’s body weight (grams) was recorded repeatedly (approximately weekly, except in week seven when two recordings were taken). 
# Overall, the study time period was 9 weeks. 

# Looking at dimension, summary, and structure of the RATS data set
dim(RATS)
str(RATS)
names(RATS)
glimpse(RATS)
summary(RATS)

# RATS data set includes 16 observations of 13 variables. 
# There are 16 rats in the study represented by IDs.They are divided in to three groups. Group1 has 8 rats and Group2 and Group3 4 rats each.
# Rest of the data includes the weight measures for the from day 1 to day 64 at approximately weekly intervals.


# Converting the categorical variables of both data sets to factors

library(dplyr)
library(tidyr)

# In BPRS categorical variables include treatment and subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# In RATS categorical variables include ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Converting the data sets to long form. Adding a week variable to BPRS and a Time variable to RATS.
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) 

BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)


# Taking a serious look at the long form data sets
dim(BPRSL)
str(BPRSL)
names(BPRSL)
summary(BPRSL)

# BPRSL long form data set includes 360 observations of five variables: treatment, subject, weeks, bprs and week.
# The long form effectively stacks the data of the weekly BPRS observations in to one column that includes all weekly BPRS measures.
# The other columns (treatment, subject, week) enables tracking of the observations.

dim(RATSL)
str(RATSL)
names(RATSL)
summary(RATSL)

# RATSL long form data set 176 observations of 5 variables: ID, Group, WD, Weight and Time.
# Similar to BPRSL, the RATSL stacks all weight observations in to one column "Weight".

write.csv(BPRSL, "BPRSL.csv", row.names = FALSE)
write.csv(RATSL, "RATSL.csv", row.names = FALSE)