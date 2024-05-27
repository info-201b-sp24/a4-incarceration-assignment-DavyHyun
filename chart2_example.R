library(tidyverse)

# Load data
data <- read.csv("prison_jail_rates.csv")

# Filter and select relevant columns
filtered_data <- data %>%
  select(year, black_prison_pop_rate, white_prison_pop_rate) %>%
  filter(!is.na(black_prison_pop_rate) & !is.na(white_prison_pop_rate))

# Summarize data annually
annual_data <- filtered_data %>%
  group_by(year) %>%
  summarize(black_prison_pop_rate = mean(black_prison_pop_rate, na.rm = TRUE),
            white_prison_pop_rate = mean(white_prison_pop_rate, na.rm = TRUE)) %>%
  pivot_longer(cols = c(black_prison_pop_rate, white_prison_pop_rate), 
               names_to = "population_type", 
               values_to = "rate")

# Plotting
ggplot(annual_data, aes(x = factor(year), y = rate, fill = population_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of Black and White Prison Population Rates Over Time",
       x = "Year",
       y = "Prison Population Rate (per 100,000 population)",
       fill = "Population Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Save the plot
ggsave("Black_White_Population_Rate_Comparison_Chart.pdf", width = 12, height = 8)
