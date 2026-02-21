# Reading in an cleaning data for California Birth and Death data

# packages for this cleaning + analysis
library(tidyverse)
library(data.table)


# read in the data for births - this is one dataset so we will not have much trouble with joins
births <- read_csv("data/20241030_births_final_state_month_sup.csv")

# from looking at the data, it appears that before 2018, the data is less granular, more aggregate
# 2018 and beyond specifies locations (hospital, birth center, home, etc)

# collect only the columns we care about: the first six columns
# data.table allows an easy way to subset the data
births <- births[,c(1:6)]

# check if any NA values remain

anyNA(births)

# No missing values remain - data cleaning is fairly easy here!

## DEATH DATA

# there are more files to read in, so let's read the first one chronologically in

deaths_70_78 <- read_csv("data/1970-1978-final-deaths-by-month-statewide.csv")

# the data appears to be much more granular going back to the 70s, with strata for age

# read in the remaining files

deaths_79_98 <- read_csv("data/1979-1998-final-deaths-by-month-statewide.csv")
deaths_99_13 <- read_csv("data/1999-2013-final-deaths-by-month-statewide.csv")
deaths_14_23 <- read_csv("data/2014-2023-final-deaths-by-month-statewide.csv")

# subset all this data s.t. we can easily bind it together, chronologically with rbind()

deaths_70_78 <- deaths_70_78[,c(1:8)]
deaths_79_98 <- deaths_79_98[,c(1:8)]
deaths_99_13 <- deaths_99_13[,c(1:8)]
deaths_14_23 <- deaths_14_23[,c(1:7,9)]

# use rbind() to stack together into one dataset
deaths <- rbind(deaths_70_78,deaths_79_98,deaths_99_13,deaths_14_23)

# this data has much more detail in cause, age, ethnicity etc

# check for missing values

anyNA(deaths)

# remove the NA values - we aren't as interested in these as we have no need to impute

deaths <- deaths %>% na.omit()

# check

anyNA(deaths)

# no more missing values!