### ===============================================================================================
###  Mestrado em Metodos Quantitativos para a Decisao Economica e Empresarial MMQDEE
###  ISEG Lisbon School of Economics and Management
###  Catarina Silva - Nº57241
###  TFM 
###  ==============================================================================================

#Delete previous data
rm(list = ls())

#Install packages
install.packages("readxl")
install.packages("bibliometrix")
install.packages("base")

#Activate packages
library(bibliometrix)
library(readxl)
library(readr)
library(dplyr)
library(lubridate)

#########################################################################################################################
########### Scopus  #####################################################################################################

#Read data scopus
scopusdata <- convert2df(
  file = "C:/Users/catar/OneDrive - ISEG/ISEG MQDEE/Tese/Query export/scopus_export_Dec 8_after_data_clean.csv",
  dbsource = "scopus",
  format = "csv"
)


#Bibliometrix
results_scopus <- biblioAnalysis(scopusdata, sep = ";")

summary(object = results_scopus, k = 10, pause = FALSE)

#Graph
plot(
  x = results_scopus,
  k = 10,
  pause = FALSE
)

#########################################################################################################################
########### PATENTSCOPE  ############################################################################################

#read data wipo
wipodata <- read_excel("C:/Users/catar/OneDrive - ISEG/ISEG MQDEE/Tese/Query export/WIPO_export_resultList_after_data_clean.xlsx",
            sheet = "ResultSet"
)

#check column names
colnames(wipodata)

#Put data set equal as Scopus 
WIPO_cldata <- data.frame(
  DB = "scopus",                    
  AU = wipodata$`Application Id`,
  TI = wipodata$Title,
  PY = substr(wipodata$`Application Date`, 7, 10),
  SO = "PATENTSCOPE",
  DE = wipodata$`I P C`,
  ID = wipodata$`I P C`,
  AB = wipodata$Abstract,
  CR = "NO REFERENCES",
  TC = 0,
  DI = wipodata$`Application Number`,
  DT = "patent",
  LA = "EN",
  stringsAsFactors = FALSE
)

WIPO_cldata[] <- lapply(WIPO_cldata, as.character)

#Bibliometrix
resultS_wipo <- biblioAnalysis(WIPO_cldata, sep = ";")

summary(resultS_wipo,k = 10, pause = FALSE)

#graph
plot(
  x = resultS_wipo,
  k = 10,
  pause = FALSE
)

#Country analysis
sort(table(wipodata$Country), decreasing = TRUE)

country_counts <- sort(table(wipodata$Country), decreasing = TRUE)

barplot(
  country_counts,
  las = 2,
  main = "Number of Patents by Jurisdiction",
  xlab = "Jurisdiction",
  ylab = "Number of Patents"
)

