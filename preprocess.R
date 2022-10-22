library(tidyverse)

df <- read_csv('source_data/data.csv') %>% select(-...1) %>% write_csv('derived_data/processed.csv')

