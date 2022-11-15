
##Libaryk betöltése
library(tidyverse)
library(rvest)
library("tryCatchLog")

###S&P500tickerek létrehozása

sp500_ticker <- read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies") %>% 
  html_table %>% 
  .[1] %>%
  reduce(c) %>% 
  select(Symbol) %>% 
  as.list()

##URL-ek készítése

for (x in sp500_ticker){
  url_nyse=paste0("https://www.responsibilityreports.com/HostedData/ResponsibilityReportArchive/a/NYSE_",x,"_2020.pdf")
  url_nasdaq=paste0("https://www.responsibilityreports.com/HostedData/ResponsibilityReportArchive/a/NASDAQ_",x,"_2020.pdf")
}

##URL-ek tisztítása

urls=tibble(url_nasdaq,url_nyse) %>% 
  mutate(
    url_nasdaq=ifelse(str_detect(url_nasdaq,"NASDAQ_A"),str_replace(url_nasdaq,"/a/","/a/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_B"),str_replace(url_nasdaq,"/a/","/b/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_C"),str_replace(url_nasdaq,"/a/","/c/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_D"),str_replace(url_nasdaq,"/a/","/d/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_E"),str_replace(url_nasdaq,"/a/","/e/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_F"),str_replace(url_nasdaq,"/a/","/f/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_G"),str_replace(url_nasdaq,"/a/","/g/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_H"),str_replace(url_nasdaq,"/a/","/h/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_I"),str_replace(url_nasdaq,"/a/","/i/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_J"),str_replace(url_nasdaq,"/a/","/j/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_K"),str_replace(url_nasdaq,"/a/","/k/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_L"),str_replace(url_nasdaq,"/a/","/l/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_M"),str_replace(url_nasdaq,"/a/","/m/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_N"),str_replace(url_nasdaq,"/a/","/n/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_O"),str_replace(url_nasdaq,"/a/","/o/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_P"),str_replace(url_nasdaq,"/a/","/p/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_R"),str_replace(url_nasdaq,"/a/","/r/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_S"),str_replace(url_nasdaq,"/a/","/s/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_T"),str_replace(url_nasdaq,"/a/","/t/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_U"),str_replace(url_nasdaq,"/a/","/u/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_V"),str_replace(url_nasdaq,"/a/","/v/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_Q"),str_replace(url_nasdaq,"/a/","/q/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_W"),str_replace(url_nasdaq,"/a/","/w/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_Z"),str_replace(url_nasdaq,"/a/","/z/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_X"),str_replace(url_nasdaq,"/a/","/x/"),
                          ifelse(str_detect(url_nasdaq,"NASDAQ_Y"),str_replace(url_nasdaq,"/a/","/y/"),
                          "semmi"))))))))))))))))))))))))))
) %>% 
  mutate( url_nyse=str_replace(url_nasdaq,"NASDAQ","NYSE"),
    url_nasdaq=replace(url_nasdaq,1,
  "https://www.responsibilityreports.com/HostedData/ResponsibilityReportArchive/3/NASDAQ_MMM_2020.pdf"),
  url_nyse=replace(url_nyse,1,
  "https://www.responsibilityreports.com/HostedData/ResponsibilityReportArchive/3/NYSE_MMM_2020.pdf")
)

url_nasdaq<-urls %>% 
  select(url_nasdaq) %>% 
  reduce(c)

url_nyse<-urls%>% 
  select(url_nyse) %>% 
  reduce(c)

###Mappa készítése

if (!dir.exists("raw_pdf_files")) {
  dir.create("raw_pdf_files")
  message("raw_pdf_files folder created!")
}

###Adatok letöltése 

oldw <- getOption("warn")
options(warn = -1)

###Nyse url-ek letöltése

for (x in url_nyse) {
  file_name <- str_c("raw_pdf_files/", gsub(".*ResponsibilityReportArchive/./", "", x))
  
  if (file.exists(file_name)) {
    message(file_name, ": This file already exists, skip to next")
    next
  } else {
    message(crayon::bgGreen("Download ", file_name))
  }
  
  tryCatch(download.file(x, destfile = file_name),
           error = function(e) print(paste(x, 'did not work out')))    
}

###NASDAQ url-ek letöltése

for (x in url_nasdaq) {
  file_name <- str_c("raw_pdf_files/", gsub(".*ResponsibilityReportArchive/./", "", x))
  
  if (file.exists(file_name)) {
    message(file_name, ": This file already exists, skip to next")
    next
  } else {
    message(crayon::bgGreen("Download ", file_name))
  }
  
  tryCatch(download.file(x, destfile = file_name),
           error = function(e) print(paste(x, 'did not work out')))    
}

options(warn = oldw)
