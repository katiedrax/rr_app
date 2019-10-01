#### Description ####

# Clean RR data downloaded from google sheet

##########
# packages#
###########

library(googlesheets)
library(tidyverse)
#########
# import#
#########

# register sheet via url
df <- gs_url("https://docs.google.com/spreadsheets/d/1D4_k-8C_UENTRtbPzXfhjEyu3BfLxdOsn9j-otrO870/edit#gid=0") %>%
  #read in
  gs_read(skip = 1)

# change encoding to latin1 to make tickmark easy to revalue

for (col in colnames(df)){
  Encoding(df[[col]]) <- "latin1"
  }

#################
# clean colnames#
#################

#check colnames with double figures
colnames(df)[grep("\\b[0-9][0-9]\\b", colnames(df))]

#check colnames with single figures
colnames(df)[grep("\\b[0-9]. \\b", colnames(df))]

##############
# DONT USE remove rows#
##############

# find row that contains 'DEFINITIONS'

#id_def <- sapply(df, function(x) which(grepl("DEFINITIONS", x)))

#id_off <- as.character(lapply(df, function(x) which(grepl("JOURNALS OFFERING", x)))) %>%
  #str_subset("^(?!.*integer)")

#make rows containing descriptive headings empty

#df <- data.frame(lapply(df, function(x) {
  #gsub(".*DO NOT QUALIFY.*", NA, x)
  #}))

#df <- data.frame(lapply(df, function(x) {
 # gsub(".*DEFINITIONS.*", NA, x)
#}))

############################
# subset into RRs & non-RRs#
############################

not_rr <- subset(df, 
                 (is.na(df[, "1. Includes pre-study peer review"])) | (is.na(df[, "2. Offers provisional pre-study acceptance"])))

rr <- subset(df, 
                 (!is.na(df[, "1. Includes pre-study peer review"])) | !(is.na(df[, "2. Offers provisional pre-study acceptance"])))


########
# clean#
########


# replace empty values with No

df[df == ""] <- "No"

# 
df <- data.frame(lapply(df, function(x) {
  gsub("?o"", "Yes", x)
}))

df <- df[-c(189:193), ]
tail(df)
df <- lapply(df[, 2:22], as.factor)
table(df$X5..Offered.for.replication.studies)
prop.table(df, 1)



 
       
       
       # remove all rows without a journal
       
       df <- df[!is.na(df$Journal),]
       
       # replace tick
       
       
       # replace NA with no
       
       df[is.na(df)] <- "No"
       
       # clean headers
       
       colnames(df) <- gsub("X[0-9]\\..|X[0-9][0-9]\\..","", colnames(df))
       
       # subset rows that do not have pre-study peer review OR don't offer IPA
       not_rr <- subset(df, 
                        (is.na(df[, "Includes.pre.study.peer.review"])) | (is.na(df[, "Offers.provisional.pre.study.acceptance"])))
       
       # subset rows that have pre-study peer review AND IPA
       
       rr <- subset(df, 
                    (!is.na(df[, "Includes.pre.study.peer.review"])) & (!is.na(df[, "Offers.provisional.pre.study.acceptance"])))
       
       ##############
       #### define input ####
       ###############
       
       observe({
         #define input as variables in rr
         updateSelectInput(session, "vars", choices = colnames(rr))
       })
       
