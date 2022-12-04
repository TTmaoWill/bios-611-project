library(tidyverse)

df <- read_csv('derived_data/processed.csv')  %>% select(-song_title, -artist)

png("figures/hists.png",width=800,height=800)
ggplot(gather(df,key='term'), aes(value)) + 
  geom_histogram(bins = 10) + 
  facet_wrap(~term, scales = 'free_x')
dev.off()
