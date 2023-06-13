library(tidyverse)

library(readr)
market_street_crime_2 <- read_csv("market_street_crime_2.csv")
View(market_street_crime_2)

market <- market_street_crime_2

# need distinct cases to check a map with.
  # I noticed there are multiple lines in the data for the same incident (via date, offense ID and location). 
  # Looks like each charge has a different line in the data.  

# From DPD PIO Officer Ulrich:
  # The Incident ID is the DPD case number assigned to that specific incident beginning with the year and the offense code indicates the type of crime. 

market %>% 
  distinct(incident_id, .keep_all = TRUE)

  # 814 rows 
    # Same in SQL, 814 rows

distinct_market <- market %>% 
  distinct(incident_id, .keep_all = TRUE)

distinct_market %>% write_csv("distinct_market.csv", na = "")

# Map showed one point outside of the perimeter we are looking for, which is 2000 BLK LAWRENCE ST / LARIMER ST ALLEY. Will need to delete and redo

### after deletion ###

library(readr)
market_street_crime_3 <- read_csv("market_street_crime_3.csv")
View(market_street_crime_2)

market <- market_street_crime_3

market %>% 
  distinct(incident_id, .keep_all = TRUE)

  # Only one address affected by that. So 813 distinct rows.
    # Echo'd in SQL, 813 rows:
   
    # SELECT DISTINCT(incident_id)
    # from market

####### group by year ############

distinct_market %>% 
  group_by(year) %>% 
  summarize(count = n()) %>% 
  View()

# Alleged crimes are becoming more common in the vicinity. There were at least 202 alleged crimes in 2022, the highest since 2018. 
  # There have been 96 incidents so far in 2023. 

  # Echoed in SQL

    # CREATE TABLE "distinct_market" as
    # SELECT DISTINCT(incident_id), year
    # from market
    
    # SELECT year, count(year) 
    # from distinct_market
    # group by year

##### Most common type of alleged crime? ######

market %>% 
  group_by(offense_type_id) %>% 
  summarize(count = n()) %>% 
  View()

# Most of the documented alleged crimes were assaults and thefts.
  # It is likely that multiple charges occurred at each incident, so a variety of alleged crimes could have happened at one incident. 
