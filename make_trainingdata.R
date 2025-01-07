# --------------------------------------------------
# select the grant truth data
# --------------------------------------------------
library(tidyverse)
library(readxl)
rm(list=ls())
setwd("/Users/birdstone/Dropbox/ChinaReturnees/data/final_datasets/cddt_paperinfo/disam")
gt_source <- read_excel("~/Dropbox/ChinaReturnees/data/final_datasets/gt_source1115.xlsx",
                        col_types = c("text", "text", "text",
                                      "text")) %>% 
    filter(is.na(year_not_cover))

gt_name <- read_csv("/Users/birdstone/Library/CloudStorage/Dropbox/ChinaReturnees/data/final_datasets/sctst_name.csv") %>% 
    semi_join(y = gt_source, by = c("uniqueID"))

write_csv(gt_name, "/Users/birdstone/Documents/GitHub/openalex_and/gt_name.csv")
write_csv(gt_source, "/Users/birdstone/Documents/GitHub/openalex_and/gt_source.csv")

# --------------------------------------------------
# get the paper id of the gt data
# run the codes in bigforce
# --------------------------------------------------

library(tidyverse)
works_au_affs <- read_csv('works_au_affs.csv')
gt_name <- read_csv("gt_name.csv")


