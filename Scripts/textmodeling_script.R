source("Scripts/library_script.R")

## Load all scraped data

D_text_raw <- readRDS("data/D_text_raw.rds")
R_text_raw <- readRDS("data/R_text_raw.rds")
trump_text_raw <- readRDS("data/trump_text_raw.rds")

## Democrat corpus and model
D_corp <- corpus(D_text_raw,
                 text_field = "text", docid_field = "id")

docvars(D_corp, "id") <- D_text_raw$id

D_corpdfm <- dfm(D_corp)

D_model <- textmodel_wordfish(D_corpdfm, dir = c(4,34)) #CA and WV

D_pred  <- predict(D_model, interval = "confidence")

D_pred <- as_tibble(D_pred$fit)

D_pred_fit <- mutate(bind_cols(docvars(D_corpdfm), D_pred),
                     st_pty_order = rank(fit)) 

D_plot <- ggplot(D_pred_fit, aes(x = fit, xmin = lwr, xmax = upr,
                       y = st_pty_order, col = party)) +
  geom_point() +
  geom_errorbarh(height = 0) +
  scale_color_manual(values = c("blue")) +
  scale_y_continuous(labels = D_pred_fit$id,
                     minor_breaks = NULL,
                     breaks = D_pred_fit$st_pty_order) +
  labs(x = "Position", y = "State Party") +
  ggtitle(label = "Estimated State Party Alignment",
          subtitle = "Democratic Platforms") +
  geom_vline(xintercept = 0, color = "black") +
  theme_minimal()

png("Output/D_plot.png", height = 600)
print(D_plot)
dev.off()

## Republican corpus and model
R_corp <- corpus(R_text_raw,
                 text_field = "text", docid_field = "id")

docvars(R_corp, "id") <- R_text_raw$id 

R_corpdfm <- dfm(R_corp)

R_model <- textmodel_wordfish(R_corpdfm, dir = c(13, 23)) #Maine and OK

R_pred  <- predict(R_model, interval = "confidence")

R_pred <- as_tibble(R_pred$fit)

R_pred_fit <- mutate(bind_cols(docvars(R_corpdfm), R_pred),
                     st_pty_order = rank(fit))

R_plot <- ggplot(R_pred_fit, aes(x = fit, xmin = lwr, xmax = upr,
                       y = st_pty_order, col = party)) +
  geom_point() +
  geom_errorbarh(height = 0) +
  scale_color_manual(values = c("red")) +
  scale_y_continuous(labels = R_pred_fit$id,
                     minor_breaks = NULL,
                     breaks = R_pred_fit$st_pty_order) +
  labs(x = "Position", y = "State Party") +
  ggtitle(label = "Estimated State Party Alignment",
          subtitle = "Republican Platforms") +
  geom_vline(xintercept = 0, color = "black") +
  theme_minimal()


png("Output/R_plot.png", height = 600)
print(R_plot)
dev.off()


## Republicans and Trump

trump_corp <- corpus(trump_text_raw,
                 text_field = "text", docid_field = "id")

docvars(trump_corp, "id") <- trump_text_raw$id 

trump_corpdfm <- dfm(trump_corp)

trump_model <- textmodel_wordfish(trump_corpdfm, dir = c(13, 23)) #Maine and OK

trump_pred  <- predict(trump_model, interval = "confidence")

trump_pred <- as_tibble(trump_pred$fit)

trump_pred_fit <- mutate(bind_cols(docvars(trump_corpdfm), trump_pred),
                     st_pty_order = rank(fit))

trump_plot <- ggplot(trump_pred_fit, aes(x = fit, xmin = lwr, xmax = upr,
                                 y = st_pty_order, col = party)) +
  geom_point() +
  geom_errorbarh(height = 0) +
  scale_color_manual(values = c("red")) +
  scale_y_continuous(labels = trump_pred_fit$id,
                     minor_breaks = NULL,
                     breaks = trump_pred_fit$st_pty_order) +
  labs(x = "Position", y = "State Party") +
  ggtitle(label = "Estimated State Party Alignment",
          subtitle = "Republican Platforms and Trump") +
  geom_vline(xintercept = 0, color = "black") +
  theme_minimal()

trump_plot

png("Output/trump_plot.png", height=600)
print(trump_plot)
dev.off()



## Make an all-encompassing corpus, model

all_text_raw <- rbind(R_text_raw, D_text_raw)

all_corp <- corpus(all_text_raw,
                   text_field = "text", docid_field = "id")

docvars(all_corp, "id") <- all_text_raw$id 

all_corpdfm <- dfm(all_corp)

all_model <- textmodel_wordfish(all_corpdfm, dir = c(39,23)) #California Ds and Oklahoma Rs

all_pred  <- predict(all_model, interval = "confidence")

all_pred <- as_tibble(all_pred$fit)

all_pred_fit <- mutate(bind_cols(docvars(all_corpdfm), all_pred),
                   st_pty_order = rank(fit)) 

all_plot <- ggplot(all_pred_fit, aes(x = fit, xmin = lwr, xmax = upr,
                     y = st_pty_order, col = party)) +
  geom_point() +
  geom_errorbarh(height = 0) +
  scale_color_manual(values = c("blue", "red")) +
  scale_y_continuous(labels = all_pred_fit$id,
                     minor_breaks = NULL,
                     breaks = all_pred_fit$st_pty_order) +
  labs(x = "Position", y = "State Party") +
  ggtitle(label = "Estimated State Party Alignment",
          subtitle = "All States and National Platforms") +
  geom_vline(xintercept = 0, color = "black") +
  theme_minimal()

png("Output/all_plot.png", height=840)
print(all_plot)
dev.off()


###Topic models
  
## Make a stopword list of states and also letters from punctuation removal

state_stopwords <- c("alabama","alaska","arizona","arkansas","california",
                     "colorado","connecticut","delaware","florida","georgia",
                     "hawaii","idaho", "illinois","indiana","iowa","kansas",'kentucky',
                     'louisiana','maine','maryland','massachusetts','michigan',
                     'minnesota','mississippi','missouri','montana','nebraska',
                     'nevada','new', 'hampshire','jersey','mexico','york',
                     'north', 'carolina','dakota','ohio','oklahoma','oregon',
                     'pennsylvania','rhode', 'island','south','dakota',
                     'tennessee', 'texas', 'utah', 'vermont', 'virginia', 'washington',
                     'west virginia', 'wisconsin', 'wyoming,')

letter_stopwords <- c("a", 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                      'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')
#some pdfs used letters instead of numbers/bullets, also some were messy pdfs and others had bad splits with removepunctuation

##frequency tables for Dems and Reps

D_words <- D_text_raw %>%
  unnest_tokens(word,text) #splits by word

D_words$word <- D_words$word %>%
  removeNumbers() %>%
  removeWords(state_stopwords) %>% #remove state names 
  removeWords(letter_stopwords) #remove split letters

D_words <- D_words[!(D_words$word == ""), ]

D_words <- D_words %>% 
  anti_join(get_stopwords()) #removes stop words

D_freq <- subset(D_words, select = c(3) )

D_freq <- D_freq %>%
  group_by(word) %>%
  mutate(word_count = n()) %>%
  distinct() %>% 
  ungroup()
  
D_freq <- D_freq[order(-D_freq$word_count),] #sort by frequency

D_freq <- top_n(D_freq, 30)

D_freq_table <- xtable(D_freq,
                       caption = c("Word Frequencies: Democrat Platforms"))

print.xtable(D_freq_table, caption.placement = "top", type="html", file="Output/D_freq_table.html")



R_words <- R_text_raw %>%
  unnest_tokens(word,text) #splits by word

R_words$word <- R_words$word %>%
  removeNumbers() %>%
  removeWords(state_stopwords) %>% #remove state names 
  removeWords(letter_stopwords) #remove split letters

R_words <- R_words[!(R_words$word == ""), ]

R_words <- R_words %>% 
  anti_join(get_stopwords()) #removes stop words

R_freq <- subset(R_words, select = c(3) )

R_freq <- R_freq %>%
  group_by(word) %>%
  mutate(word_count = n()) %>%
  distinct() %>% 
  ungroup()

R_freq <- R_freq[order(-R_freq$word_count),] #sort by frequency

R_freq <- top_n(R_freq, 30)

R_freq_table <- xtable(R_freq,
             caption = c("Word Frequencies: Republican Platforms"))
      
print.xtable(R_freq_table, caption.placement = "top", type="html", file="Output/R_freq_table.html")

## TFIDF

all_words <- all_text_raw %>%
  unnest_tokens(word,text) #splits by word

all_words$word <- all_words$word %>%
  removeNumbers() %>%
  removeWords(state_stopwords) %>% #remove state names 
  removeWords(letter_stopwords) #remove split letters

all_words <- all_words[!(all_words$word == ""), ]

all_words <- all_words %>% 
  anti_join(get_stopwords()) #removes stop words

all_count_plot <- all_words %>% ##by state
  count(id, word, sort = TRUE) %>%
  bind_tf_idf(word, id, n) %>%
  group_by(id) %>%
  top_n(5) %>%
  ungroup %>%
  mutate(word = reorder(word, tf_idf)) %>%
  ggplot(aes(word, tf_idf)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~id, scales = "free") +
  coord_flip()

png("Output/all_count_plot.png", height=1000, width =2000)
print(all_count_plot)
dev.off()

party_count_plot <- all_words %>% ##by party
  count(party, word, sort = TRUE) %>%
  bind_tf_idf(word, party, n) %>%
  group_by(party) %>%
  top_n(5) %>%
  ungroup %>%
  mutate(word = reorder(word, tf_idf)) %>%
  ggplot(aes(word, tf_idf)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~party, scales = "free") +
  coord_flip()

png("Output/party_count_plot.png")
print(party_count_plot)
dev.off()
