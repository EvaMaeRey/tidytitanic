library(tidyverse)

Titanic %>%
  data.frame() %>%
  janitor::clean_names() %>%
  tibble() ->
  flat_titanic

Titanic %>%
  data.frame() %>%
  janitor::clean_names()%>%
  uncount(weights = freq) %>%
  mutate(id = 1:n(), .before = 1) %>%
  tibble::remove_rownames() %>%
  tibble() ->
  tidy_titanic

usethis::use_data(flat_titanic, overwrite = TRUE)
usethis::use_data(tidy_titanic, overwrite = TRUE)
