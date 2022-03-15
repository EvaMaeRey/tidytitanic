library(tidyverse)

Titanic %>%
  data.frame() ->
flat_titanic

Titanic %>%
  data.frame() %>%
  uncount(weights = Freq) %>%
  mutate(id = 1:n()) ->
tidy_titanic

save(flat_titanic, file = "data/flat_titanic.Rdata")
save(tidy_titanic, file = "data/tidy_titanic.Rdata")
