# Data Wrangling
library(tidyverse)
library(lubridate)

# Visualisasi
library(ggplot2)
library(plotly)
library(glue)
library(scales)

# Shiny
library(shinydashboard)
library(shiny)

# Read Data
ikea <- read.csv("data_input/ikea.csv")

# Data Wrangling
ikea <- ikea %>% 
  select(-X, -link, -short_description, -name, -old_price) %>% 
  na.omit() %>% 
  separate_rows(designer, sep = "/") %>% 
  filter(designer %in% c("IKEA of Sweden", "Karl Malmvall", "J Karlsson", "N Karlsson", "Francis Cayouette", "Ola Wihlborg", "Marcus Arvonen", "Nike Karlsson", "K Hagberg", "M Hagberg", "Jonas Hultqvist", "Ebba Strandmark", "Carina Bengs", "L Hilland	", "Fredriksson","David Wahl", "John", "Jonas", "Caroline", "Paul", "Petrus", "Hilland", "Chris Martin" ))

ikea_clean <- ikea %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(price_in_rp = price * 3817.76)

df2 <- ikea_clean %>% 
  filter(category %in% c("Wardrobes", "Chairs", "Cabinets & cupboards", "Beds", "Bar furniture")) %>% 
  select(category, other_colors, price_in_rp)










