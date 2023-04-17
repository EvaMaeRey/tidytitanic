library(tidyverse)

Titanic %>%
  data.frame() %>%
  janitor::clean_names() ->
  flat_titanic

Titanic %>%
  data.frame() %>%
  janitor::clean_names()%>%
  uncount(weights = freq) %>%
  mutate(id = 1:n(), .before = 1) ->
  tidy_titanic

tidy_titanic %>% filter(class != "Crew")

usethis::use_data(tidy_titanic, overwrite = TRUE)
usethis::use_data(flat_titanic, overwrite = TRUE)

# added https://github.com/clauswilke/dviz.supp/blob/master/data/titanic_all.rda as well
# added passenger_detail

passengers <- titanic_all
save(passengers, file = "data/passengers.rda")
usethis::use_data(passengers, overwrite = TRUE)

