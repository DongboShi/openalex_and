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

#write_csv(gt_name, "/Users/birdstone/Documents/GitHub/openalex_and/gt_name.csv")
#write_csv(gt_source, "/Users/birdstone/Documents/GitHub/openalex_and/gt_source.csv")

# --------------------------------------------------
# get the paper id of the gt data
# run the codes in Bigforce
# --------------------------------------------------

library(tidyverse)
works_au_affs <- read_csv('works_au_affs.csv')
gt_name <- read_csv("gt_name.csv")
dim(works_au_affs)
sum(str_count(works_au_affs$raw_author_name," +")==1)

works_au_affs <- works_au_affs %>% 
    mutate(raw_author_name = str_replace_all(raw_author_name,'[>\\"\\*？\\?\\.=\\&#\\\\]'," "),
           raw_author_name = str_replace_all(raw_author_name,'\\&NA'," "),
           raw_author_name = str_replace_all(raw_author_name,'\\s(de|da|van|von|las|la|le|del|dos|De|Da|Van|Von|Las|La|Le|Del|Dos)\\s'," "),
           raw_author_name = str_replace_all(raw_author_name,'(Jr|Dr|Ms)\\s'," "),
           raw_author_name = str_replace_all(raw_author_name,'\\s+'," "))
# write_csv(works_au_affs,file="works_au_affs_neat.csv")
works_au_affs %>% filter(raw_author_name == "He Rui") %>% dim()
gt_name <- gt_name %>% 
    mutate(count =str_length(givenname),
           givenname = if_else(str_length(givenname)==2 & !str_detect(givenname,"[aoeiu]"),
                               str_c(sep=" ",str_sub(givenname,1,1),str_sub(givenname,2,2)),
                               givenname),
           fullname = str_c(sep=" ",givenname,familyname))
gt_name <- gt_name %>% mutate(count2 =str_length(givenname))
# write_csv(gt_name,"gt_name.csv")
gt_name <- read_excel("gt_name.xlsx")
gt_name <- gt_name %>% select(-count,-count2)

cddt_paper <- works_au_affs %>% 
    inner_join(y = gt_name %>% select(uniqueID,fullname,type), 
               by = c("raw_author_name" = "fullname")) %>% 
    select(work_id,author_id,raw_author_name,uniqueID,author_position,
           raw_affiliation_string,institution_ids,is_corresponding)

paperID <- cddt_paper %>% distinct(work_id)
au_affs <- works_au_affs %>% inner_join(paperID, by = "work_id")

write_csv(paperID, file = "./openalex_disam/paperID.csv")
write_csv(au_affs, file = "./openalex_disam/au_affs.csv")
write_csv(cddt_paper, file = "./openalex_disam/cddt_paper.csv")

# ----------------------------------
# select other information from pgsql
# ----------------------------------
and_paperid
title 
journal
keywords
