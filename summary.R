library(dplyr)

prison_data <- read.csv("prison_pop_county_state.csv")

total_records <- prison_data %>% 
  summarise(Total_Records = n())

unique_counties <- prison_data %>% 
  summarise(Unique_Counties = n_distinct(county_name))

unique_states <- prison_data %>% 
  summarise(Unique_States = n_distinct(state))

latest_year <- prison_data %>% 
  summarise(Latest_Year = max(year, na.rm = TRUE))

earliest_year <- prison_data %>% 
  summarise(Earliest_Year = min(year, na.rm = TRUE))
