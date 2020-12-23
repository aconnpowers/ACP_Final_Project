library(dplyr)
library(ggplot2)
library(ggrepel)
library(kableExtra)
library(pdftools)
library(quanteda)
library(quanteda.textmodels)
library(rvest)
library(xtable)
library(stm)
library(stringr)
library(tidytext)
library(tidyverse)
library(tm)

clean_scrape <- function(text, state, party) {
  text <- text %>%
    str_replace_all("\\n|\\t|\\r|•"," ") %>% 
    tolower() %>%
    str_replace_all("[:punct:]"," ")
  text_df <- as.data.frame(text)
  text_df <- text_df %>%
    distinct() %>%
    mutate(id = paste(state, party, sep="_"))
  text_df <- text_df  %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(text = paste(text, collapse = " ")) %>%
    mutate(party = party) %>%
    mutate(id = paste(state, party, sep="_"))
}

join_scrape <- function(text, state, party) {
  text_df <- data.frame(text = unlist(text)) %>%
    mutate(id = paste(state, party, sep="_")) 
  text_df <- text_df %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(text = paste(text, collapse = " ")) %>%
    mutate(party = party) %>%
    mutate(id = paste(state, party, sep="_"))
}

