#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

#Data Import
import_tbl <- read_delim("../data/week4.dat", delim = '-', col_names = c('casenum', 'parnum', 'stimver', 'datadate', 'qs'))
summary(import_tbl)
wide_tbl <- separate(data = import_tbl, col = "qs", into = c('q1', 'q2', 'q3', 'q4', 'q5')) 
wide_tbl[5:9] <- sapply(wide_tbl[5:9], as.integer)
wide_tbl <- wide_tbl %>% mutate(datadate = mdy_hms(datadate))
wide_tbl <- wide_tbl %>% replace_na(list(q1 = 0L, q2 = 0L, q3 = 0L, q4 = 0L, q5 = 0L))
wide_tbl <- wide_tbl %>% filter(q2 != 0)
long_tbl <- wide_tbl %>% pivot_longer(cols = 5:9, names_to = "question", values_to = "response")