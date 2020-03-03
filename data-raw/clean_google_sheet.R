#############################
#
# Author: Gina Nichols
#
# Date Created: March 2 2020, last modified March 2 2020
#
# Purpose: Clean data into form that will be published and used for further analyses
#
# Inputs: google sheet
#
# Outputs: package data
#
# Notes:
#
##############################

library(tidyverse)
library(janitor) #--to clean things


datraw <- read_csv("data-raw/rd_cc-database.csv")

ccweeddat <-
  datraw %>%
  mutate(exp_type = str_remove_all(exp_type, " "),
         exp_type = str_remove_all(exp_type, "-"),
         cc_spec = str_replace_all(cc_spec, "/", "+")) %>%
  mutate(cc_pMNTH = str_sub(cc_pMNTH, 1, 3),
         crop_pMNTH = str_sub(crop_pMNTH, 1, 3),
         cc_termMNTH = str_sub(cc_termMNTH, 1, 3)) %>%
  mutate(cc_termMETH = ifelse(cc_termMETH == "mowed", "mowing", cc_termMETH),
         cc_termMETH = ifelse(cc_termMETH == "rolling", "roller crimper", cc_termMETH),
         cc_termMETH = ifelse(cc_termMETH == "winterkill", "winter kill", cc_termMETH),
         cc_termMETH = ifelse(cc_termMETH == "chopping", "mowing", cc_termMETH)) %>%
  clean_names() %>%
  select(-entered_by, -loc_state, -notes, -map, -mat,
         -cc_p_date, -cc_tillage, -cc_term_date, -crop_p_date) %>%
  rename(pH = p_h,
         cc_wden = ccden,
         ctl_wden = ctlden,
         cc_wbio = ccbio,
         ctl_wbio = ctlbio,
         cc_bm_kgha = cc_bio_kgha)

ccweeddat
use_data(ccweeddat, overwrite = T)

