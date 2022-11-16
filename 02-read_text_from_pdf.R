csr_raw_text_df <- tibble(file_name = list.files("raw_pdf_files/", full.names = TRUE)) %>%
  transmute(
    company = str_sub(file_name, 16, -5),
    raw_text = map(file_name, pdftools::pdf_text)
  )

saveRDS(csr_raw_text_df, "intermediate-data/csr_raw.rds")
