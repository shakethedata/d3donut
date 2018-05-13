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


df <-readr::read_csv ('./www/donut2.csv')
df2 <- filter(df, id != "CT", !stringr::str_detect(links, "CT"))
df_conv1 <- convert_data (df)
df_conv2 <- convert_data (df2)
