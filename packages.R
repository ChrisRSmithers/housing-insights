# install.packages("rtweet")
# install.packages("tidytext")
# install.packages("tidyverse")
# 
# library(rtweet)
# library(tidytext)
# library(tidyverse)
# rent_tweets<-search_tweets(q = "rent+london", n=10000)

word_list<-rent_tweets %>%
  mutate(text=gsub("http|https.*","",text)) %>% 
  distinct(user_id, .keep_all = T) %>% 
  unnest_tokens(word,text) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word,"rent|london")) %>% 
  group_by(word) %>% 
  summarise(n=n()) %>% 
  arrange(-n)

head(word_list,20)