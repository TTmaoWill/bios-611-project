library(tidyverse)
library(gbm);

df <- read_csv('derived_data/processed.csv') 
select <- dplyr::select;

explanatory <- df %>% select(-song_title,-artist,-target) %>% names()
formula <- as.formula(sprintf("target ~ %s", paste(explanatory, collapse=" + ")));

tts <- runif(nrow(df)) < 0.7;

train <- df %>% filter(tts);
test <- df %>% filter(!tts);


model <- gbm(formula, data=train);

prob <- predict(model, newdata=test, type="response");


rate <- function(a){
  sum(a)/length(a);
}

maprbind <- function(f,l){
  do.call(rbind, Map(f, l));
}

roc <- maprbind(function(thresh){
  ltest <-  test %>%   mutate(target_pred=1*(prob>=thresh)) %>%
    mutate(correct=target_pred == target);
  tp <- ltest %>% filter(ltest$target==1) %>% pull(correct) %>% rate();
  fp <- ltest %>% filter(ltest$target==0) %>% pull(correct) %>% `!`() %>% rate();
  tibble(threshold=thresh, true_positive=tp, false_positive=fp);
},seq(from=0, to=1, length.out=10)) %>% arrange(false_positive, true_positive)

png("figures/roc.png")
ggplot(roc, aes(false_positive, true_positive)) + geom_line(size = 2) + 
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color="red", size=1.5)
dev.off()
