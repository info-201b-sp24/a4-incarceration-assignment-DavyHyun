# Load necessary libraries
library(tidyverse)
library("maps")
library("mapproj")
library(ggplot2)

state_shape <- map_data("state")
state_abbrevs <- data.frame(state.abb, state.name)

data <- read.csv("prison_pop_county_state.csv")

filtered_data <- data %>%
  filter(!is.na(black_prison_pop) & black_prison_pop > 0)

latest_year_data <- filtered_data %>%
  group_by(state, county_name) %>%
  filter(year == max(year)) %>%
  ungroup()

latest_year_data <- latest_year_data %>%
  select(state, county_name, black_prison_pop)

joined_data <- left_join(state_abbrevs, latest_year_data, by = c("state.abb" = "state"))
joined_data <- joined_data %>% 
  mutate(region = tolower(state.name))

state_shape <- left_join(state_shape, joined_data)

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),  
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()      
  )

ggplot(state_shape) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = black_prison_pop)) +
  coord_map() +
  labs(title = "Black Population in Jail In America",
       fill = "Black Population in Jail") +
  blank_theme
