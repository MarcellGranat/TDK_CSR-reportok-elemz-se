library(tidyverse)

csr_raw_text_df <- tibble(file_name = list.files("raw_pdf_files/", full.names = TRUE)) %>% 
  mutate(
    company = str_sub(file_name, 21, -10),
    time = str_sub(file_name, -8, -5),
    raw_text = map(file_name, pdftools::pdf_text)
  )

