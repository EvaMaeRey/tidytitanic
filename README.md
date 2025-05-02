
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidytitanic

<!-- badges: start -->
<!-- badges: end -->

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("remotes")
remotes::install_github("EvaMaeRey/tidytitanic")
```

``` r
library(tidytitanic)
tidy_titanic |> head()
#>   id class  sex   age survived
#> 1  1   3rd Male Child       No
#> 2  2   3rd Male Child       No
#> 3  3   3rd Male Child       No
#> 4  4   3rd Male Child       No
#> 5  5   3rd Male Child       No
#> 6  6   3rd Male Child       No

flat_titanic |> head()
#>   class    sex   age survived freq
#> 1   1st   Male Child       No    0
#> 2   2nd   Male Child       No    0
#> 3   3rd   Male Child       No   35
#> 4  Crew   Male Child       No    0
#> 5   1st Female Child       No    0
#> 6   2nd Female Child       No    0

passengers |> head()
#>   passenger_id survived pclass
#> 1            1        0      3
#> 2            2        1      1
#> 3            3        1      3
#> 4            4        1      1
#> 5            5        0      3
#> 6            6        0      3
#>                                                  name    sex age sib_sp parch
#> 1                             Braund, Mr. Owen Harris   male  22      1     0
#> 2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38      1     0
#> 3                              Heikkinen, Miss. Laina female  26      0     0
#> 4        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35      1     0
#> 5                            Allen, Mr. William Henry   male  35      0     0
#> 6                                    Moran, Mr. James   male  NA      0     0
#>             ticket    fare cabin embarked
#> 1        A/5 21171  7.2500              S
#> 2         PC 17599 71.2833   C85        C
#> 3 STON/O2. 3101282  7.9250              S
#> 4           113803 53.1000  C123        S
#> 5           373450  8.0500              S
#> 6           330877  8.4583              Q
```

``` r
library(tidytitanic)

head(flat_titanic)
#>   class    sex   age survived freq
#> 1   1st   Male Child       No    0
#> 2   2nd   Male Child       No    0
#> 3   3rd   Male Child       No   35
#> 4  Crew   Male Child       No    0
#> 5   1st Female Child       No    0
#> 6   2nd Female Child       No    0
head(tidy_titanic)
#>   id class  sex   age survived
#> 1  1   3rd Male Child       No
#> 2  2   3rd Male Child       No
#> 3  3   3rd Male Child       No
#> 4  4   3rd Male Child       No
#> 5  5   3rd Male Child       No
#> 6  6   3rd Male Child       No
head(passengers)
#>   passenger_id survived pclass
#> 1            1        0      3
#> 2            2        1      1
#> 3            3        1      3
#> 4            4        1      1
#> 5            5        0      3
#> 6            6        0      3
#>                                                  name    sex age sib_sp parch
#> 1                             Braund, Mr. Owen Harris   male  22      1     0
#> 2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38      1     0
#> 3                              Heikkinen, Miss. Laina female  26      0     0
#> 4        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35      1     0
#> 5                            Allen, Mr. William Henry   male  35      0     0
#> 6                                    Moran, Mr. James   male  NA      0     0
#>             ticket    fare cabin embarked
#> 1        A/5 21171  7.2500              S
#> 2         PC 17599 71.2833   C85        C
#> 3 STON/O2. 3101282  7.9250              S
#> 4           113803 53.1000  C123        S
#> 5           373450  8.0500              S
#> 6           330877  8.4583              Q
```

### What’s inside, A. Prepping data

For this package, preparation happens in the `data-raw` folder, in a
file called `dataset_prep`.

``` r
flat_titanic <- Titanic |>
  data.frame() |>
  janitor::clean_names() |>
  tibble::tibble()

usethis::use_data(flat_titanic, overwrite = T)
#> ✔ Setting active project to '/Users/evangelinereynolds/Google Drive/r_packages/tidytitanic'
#> ✔ Saving 'flat_titanic' to 'data/flat_titanic.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')

library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4          ✔ readr     2.1.5     
#> ✔ forcats   1.0.0          ✔ stringr   1.5.1     
#> ✔ ggplot2   3.5.1.9000     ✔ tibble    3.2.1     
#> ✔ lubridate 1.9.3          ✔ tidyr     1.3.1     
#> ✔ purrr     1.0.2          
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
tidy_titanic <- Titanic |>
  data.frame() |>
  janitor::clean_names()|>
  uncount(weights = freq) |>
  mutate(id = 1:n(), .before = 1) |>
  remove_rownames() |>
  tibble()

usethis::use_data(tidy_titanic, overwrite = T)
#> ✔ Saving 'tidy_titanic' to 'data/tidy_titanic.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')


passengers <- bind_rows(titanic::titanic_train, 
          titanic::titanic_test) |>
  janitor::clean_names() 

usethis::use_data(passengers, overwrite = T)
#> ✔ Saving 'passengers' to 'data/passengers.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
```

# document data

``` r


#' Tallied characteristics
#'
#' A dataset tallying frequencies of titanic passenger characteristics based on Titanic data from base R.  Includes Crew
#'
#' @format A data frame with 32 rows and 5 variables:
#' \describe{
#'   \item{class}{class (1st, 2nd, 3rd or Crew)}
#'   \item{sex}{sex of passenger}
#'   \item{age}{child or adult}
#'   \item{survived}{survival outcome of passanger}
#'   \item{freq}{tally of all in category}
#'   ...
#' }
#' @source R stats
"flat_titanic"
#> [1] "flat_titanic"


#' 
#'
#' A dataset titanic passengers and characteristics based on Titanic data from base R.  Includes Crew
#'
#' @format A data frame with 2201 rows and 5 variables:
#' \describe{
#'   \item{id}{an id for each passenger}
#'   \item{class}{class (1st, 2nd, 3rd or Crew)}
#'   \item{sex}{sex of passenger}
#'   \item{age}{child or adult}
#'   \item{survived}{survival outcome of passanger}

#'   ...
#' }
#' @source R stats
"tidy_titanic"
#> [1] "tidy_titanic"



#' Titanic test data.
#'
#' @format Data frame with columns
#' \describe{
#' \item{passenger_id}{Passenger ID}
#' \item{survived}{survival status}
#' \item{pclass}{Passenger Class}
#' \item{name}{Name}
#' \item{sex}{Sex}
#' \item{age}{Age}
#' \item{sib_sp}{Number of Siblings/Spouses Aboard}
#' \item{parch}{Number of Parents/Children Aboard}
#' \item{ticket}{Ticket Number}
#' \item{fare}{Passenger Fare}
#' \item{cabin}{Cabin}
#' \item{embarked}{Port of Embarkation}
#' 
#' ...
#' }
#' @source titanic package, https://www.kaggle.com/c/titanic/data
"passengers"
#> [1] "passengers"
```

titanic is an R package containing data sets providing information on
the fate of passengers on the fatal maiden voyage of the ocean liner
“Titanic”, with variables such as economic status (class), sex, age and
survival. These data sets are often used as an introduction to machine
learning on Kaggle. More details about the competition can be found
here, and the original data sets can be found here.

``` r
knitrExtra::chunk_to_dir("data_documentation", dir = "R")
#> It seems you are currently knitting a Rmd/Qmd file. The parsing of the file will be done in a new R session.
```

``` r
devtools::document()
devtools::check()
devtools::install(".", upgrade = "never")
devtools::submit_cran()
```
