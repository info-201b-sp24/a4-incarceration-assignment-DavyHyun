library(tidyverse)
data <- read.csv("prison_pop_county_state.csv")

filtered_data <- data %>%
  select(year, 
         `AAPI Population` = aapi_prison_pop, 
         `Black Population` = black_prison_pop, 
         `White Population` = white_prison_pop, 
         `Native Population` = native_prison_pop, 
         `Latinx Population` = latinx_prison_pop, 
         `Other Population` = other_race_prison_pop) %>%
  gather(key = "race", value = "population", -year) %>%
  filter(!is.na(population))

annual_data <- filtered_data %>% 
  group_by(year, race) %>%
  summarize(total_population = sum(population, na.rm = TRUE))

ggplot(annual_data, aes(x = year, y = total_population, color = race)) +
  geom_line() +
  labs(title = "Prison Population Trends by Race Over Time",
       x = "Year",
       y = "Total Prison Population (in tens of thousands)",
       color = "Race") +
  scale_y_continuous(labels = scales::comma_format(scale = 1e-4)) +
  theme_minimal()

ggsave("Race_Trends_Over_Time.pdf", width = 15, height = 6)
