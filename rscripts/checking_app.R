# Description

# Use this code to manually check the frequency tables produced in the rr_app to those produced by from a csv download of the data from https://docs.google.com/spreadsheets/d/1D4_k-8C_UENTRtbPzXfhjEyu3BfLxdOsn9j-otrO870/edit#gid=0

# install packages

library(shiny)
library(tidyverse)
library(googlesheets)

##################
#### import data ####
###################

# register sheet via url
df <- googlesheets::gs_url("https://docs.google.com/spreadsheets/d/1D4_k-8C_UENTRtbPzXfhjEyu3BfLxdOsn9j-otrO870/edit#gid=0") %>%
  #read in
  googlesheets::gs_read(skip = 1)

#df <- read.csv(file = "data/Comparison of Registered Reports - Sheet1.csv", stringsAsFactors = F, header = T, skip =1,
#na.strings = c("", NA), encoding = "UTF-8") 

#df <- rename(df, "Includes pre-study peer review" = "X1..Includes.pre.study.peer.review", "Offers provisional pre-study acceptance" = "X2..Offers.provisional.pre.study.acceptance")

##################
#### clean data ####
###################  

# remove all rows without a journal

df <- df[!is.na(df$Journal),]

# replace unicode tick
df[] <- lapply(df, function(x) gsub("[\u2713]", "Yes", x))

# replace NA with no

df[is.na(df)] <- "No"

# replace TBD

df[df == "TBD"] <- "To be decided"

# replace TBA

df[df == "TBA"] <- "To be announced"

# clean headers

colnames(df) <- gsub("[0-9]\\. |[0-9][0-9]\\. ","", colnames(df))

# replace all carriage return separately (lapply with str_replace_all, trimws and gsub doesn't seem to work)


df$`Offered for meta-analysis` <- gsub("[\n]", "No", df$`Offered for meta-analysis`)
df$`Offered for analyses of existing data sets` <- gsub("[\n]", "No", df$`Offered for analyses of existing data sets`)
df$`Publishes Registered Reports only`<- gsub("[\n]", "No", df$`Publishes Registered Reports only`)
df$`Publishes accepted protocols, in full or part, prior to study completion`<- gsub("[\n]", "No", df$`Publishes accepted protocols, in full or part, prior to study completion`)
df$`Offers incremental (sequential) registration`<- gsub("[\n]", "No", df$`Offers incremental (sequential) registration`)
df$`Offers incremental addition of unregistered studies`<- gsub("[\n]", "No", df$`Offers incremental addition of unregistered studies`)
df$`Offered for qualitative research`<- gsub("[\n]", "No", df$`Offered for qualitative research`)


# subset rows that do not have pre-study peer review OR don't offer IPA

not_rr <- df[(df$`Includes pre-study peer review`!= "Yes" | df$`Offers provisional pre-study acceptance` != "Yes"),]

# subset rows that have pre-study peer review AND IPA

rr <- df[(df$`Includes pre-study peer review`== "Yes" & df$`Offers provisional pre-study acceptance` == "Yes"),]

df_goo <- df
rr_goo <- rr
not_rr_goo <- not_rr

##############
#### import csv version ####
############


df <- read.csv("data/191004_Comparison of Registered Reports.csv", skip = 2, encoding = "UTF-8", header = F, na.strings = c("", " ", NA))
length(colnames(df_goo))
colnames(df) <- colnames(df_goo)

##################
#### clean data ####
###################  

# remove all rows without a journal

df <- df[!is.na(df$Journal),]

# replace unicode tick
df[] <- lapply(df, function(x) gsub("[\u2713]", "Yes", x))

# replace NA with no

df[is.na(df)] <- "No"

# replace TBD

df[df == "TBD"] <- "To be decided"

# replace TBA

df[df == "TBA"] <- "To be announced"

# replace all carriage return separately (lapply with str_replace_all, trimws and gsub doesn't seem to work)


df$`Offered for meta-analysis` <- gsub("[\n]", "No", df$`Offered for meta-analysis`)
df$`Offered for analyses of existing data sets` <- gsub("[\n]", "No", df$`Offered for analyses of existing data sets`)
df$`Publishes Registered Reports only`<- gsub("[\n]", "No", df$`Publishes Registered Reports only`)
df$`Publishes accepted protocols, in full or part, prior to study completion`<- gsub("[\n]", "No", df$`Publishes accepted protocols, in full or part, prior to study completion`)
df$`Offers incremental (sequential) registration`<- gsub("[\n]", "No", df$`Offers incremental (sequential) registration`)
df$`Offers incremental addition of unregistered studies`<- gsub("[\n]", "No", df$`Offers incremental addition of unregistered studies`)
df$`Offered for qualitative research`<- gsub("[\n]", "No", df$`Offered for qualitative research`)


# subset rows that do not have pre-study peer review OR don't offer IPA

not_rr <- df[(df$`Includes pre-study peer review`!= "Yes" | df$`Offers provisional pre-study acceptance` != "Yes"),]

# subset rows that have pre-study peer review AND IPA

rr <- df[(df$`Includes pre-study peer review`== "Yes" & df$`Offers provisional pre-study acceptance` == "Yes"),]

# NOT AUTOMATED - compare tables (including NA = "ifany") of variables in rr to those generated for same variable in app at https://katiedrax.shinyapps.io/cos_registered_reports/
