# loading packages

library(tidyverse)
library(lubridate)
library(janitor)
library(dplyr)
library(tidyr)
library(ggplot2)

# loading dataset 
daily_activity <- read.csv("dailyActivity_merged.csv")
calories <- read.csv("dailyCalories_merged.csv")
intensity <- read.csv("dailyintensities_merged.csv")
sleep <- read.csv("sleepDay_merged.csv")
weight <- read.csv("weightLoginfo_merged.csv")

head(daily_activity)
str(daily_activity)

# checking for distinct entries

n_distinct(daily_activity$Id)   #33
n_distinct(calories$Id)         #33
n_distinct(intensity$Id)        #33
n_distinct(sleep$Id)            #24
n_distinct(weight$Id)           #8(not relevant very less entries)

# performing analysis

daily_activity %>% 
  select(TotalDistance, TotalSteps, Calories, SedentaryMinutes, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>% 
  summary()

calories %>% 
  select(Calories) %>% 
  summary()

sleep %>% 
  select(TotalMinutesAsleep, TotalTimeInBed) %>% 
  summary()

intensity %>% 
  select(SedentaryMinutes) %>% 
  summary()

# findings- 
# avg steps daily - 7638, avg sedentary mins - 1057, avg distance - 5.490
# most people are lightly active


# visualistaion 
# trying to find relation between total steps vs calories burned.

ggplot(data=daily_activity, aes(x=TotalSteps, y=Calories)) +
geom_point() + geom_smooth() + geom_jitter() + labs(title = "Total steps vs calories")

#positive relation between the two. 

#trying to find relation between sleep vs total time in bed

ggplot(data=sleep, aes(x=TotalMinutesAsleep, y=TotalTimeInBed )) +
  geom_point() +  geom_jitter() + labs(title = "Total mins sleep vs Total time in bed")

#positive relation found

# trying to find a relation between sedentry minutes vs calories burned
merged_data <- merge(intensity, calories, by=c('Id', 'ActivityDay'))
head(merged_data)

ggplot(data=merged_data, aes(x=SedentaryMinutes, y=Calories)) +
  geom_point() + geom_jitter() + geom_smooth() + labs(title = "sedentary minutes vs Calories burned")

# No clear trend found.

install.packages("rmarkdown")
library(rmarkdown)
render("bellabeat casestudy.R")




