library(tidyverse);

df <- read_csv('derived_data/processed.csv')

df.pca <- prcomp(df %>% select(-song_title, -artist))

png("figures/pca.png")
ggplot(df.pca$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point();
dev.off()