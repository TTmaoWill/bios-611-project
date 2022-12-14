library(tidyverse);
library(reticulate);

df <- read_csv('derived_data/processed.csv')

use_python("/usr/bin/python3");
# use_python("/Users/chenweit/anaconda3/envs/deep_learning/python.exe");
manifold <- import("sklearn.manifold");

tsne_instance <- manifold$TSNE(n_components=as.integer(2));
results <- tsne_instance$fit_transform(df %>% select(-song_title, -artist, -target) %>% as.matrix()) %>%
  as_tibble();

png("figures/tsne.png")
ggplot(results, aes(V1, V2)) + geom_point()
dev.off()