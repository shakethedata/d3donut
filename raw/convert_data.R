# read in csv and convert data for app without names
# map each item to an anonymised decode 
convert_data <- function (df) {
  
mapping_list <-                      
df %>% 
  group_by (sector) %>% 
  distinct(id) %>% 
  mutate(decode = paste0(sector, row_number())) %>% 
  ungroup () %>% 
  select (id, decode) %>% 
  tibble::deframe()

decode_names <- function (mystring) {
  toString (unname (mapping_list [unlist(strsplit(mystring, split=' '))]))
}

df_conv <-
  df %>% 
  mutate (conv_links = purrr::map (links, decode_names)) %>% 
  mutate (conv_id = purrr::map (id, decode_names)) %>% 
  mutate (conv_name = purrr::map (id, decode_names)) %>% 
  select (name = conv_name, weight, sector, id = conv_id, links = conv_links) %>% 
  tidyr::unnest()
}

library(dplyr)
df <-readr::read_csv ('./raw/donut2.csv')
df2 <- dplyr::filter(df, id != "CT", !stringr::str_detect(links, "CT"))
donut_data1 <- convert_data (df)
donut_data2 <- convert_data (df2)

# save(donut_data1, file="data/donut_data1.rda")
# save(donut_data2, file="data/donut_data2.rda")
use_data(donut_data1)
use_data(donut_data2)





