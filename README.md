
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidytitanic

<!-- badges: start -->

<!-- badges: end -->

## Goal 1. tidy data

The goal of tidytitanic provide ‘flat’ versions of the Titanic dataset
which is available in R. See how to use in ‘Step 2. Imagine Another Way’
in the Package development Guide below.

## Goal 2. package development practice

This repository is also intended to introduce the data package building
process. {tidytitanic} was the ‘toy’ project I used as a practice for
creating a larger data package with collaborators. I made use of the
data section of the R Packages book `https://r-pkgs.org/data.html` to
get up and running.

Now, I’d like to introduce this ‘toy’ package as a point of entry for
others to get into package development.

Here some motivation:

1.  **Data packages are fun to make.**
2.  **Data packages are ‘safe’.** They don’t require much API design
    (sometimes it is a good idea to take longer time w/ functions to
    develop API); we might expect less drift in API.  
3.  **Data packages are packages\!** Building a data package covers a
    lot of the same ground as building other types of R packages. So
    knowledge can be transferred to ‘function-type’ packages.
4.  **Data packages are impactful.** And delivering easy-to-use data can
    help people get to the rewarding, fun things (cool
    analytics/modeling/visualization) faster. And, if you are a cool
    cat/rare bird that loves data cleaning, you get to do that in the
    package build\! (see 1.)

# Package development practice

## Step 1. Identify a problem

The `Titanic` dataset from R’s {datasets} package is compelling and
familiar data. But it is hard to get going with using popular tools
because it is in an array. It’s not many steps to flatten and clean it,
but this takes a few steps which might distract you from the main goals
of using it as an example. A package seems worthwhile to provide flat
data. A ready-to-go uncounted version may also be useful in demoing
operations on ‘individual’ or ‘record’ level data.

Here are the steps to flattening and then uncounting:

``` r
library(magrittr)
#> Warning: package 'magrittr' was built under R version 3.6.2
my_titanic <- Titanic %>% 
  data.frame() %>% 
  janitor::clean_names() %>% 
  tidyr::uncount(freq) %>% 
  tibble::tibble()

head(my_titanic)
#> # A tibble: 6 × 4
#>   class sex   age   survived
#>   <fct> <fct> <fct> <fct>   
#> 1 3rd   Male  Child No      
#> 2 3rd   Male  Child No      
#> 3 3rd   Male  Child No      
#> 4 3rd   Male  Child No      
#> 5 3rd   Male  Child No      
#> 6 3rd   Male  Child No
```

## Step 2. Imagine another way\!

What if you just installed a package that had all of this work done for
you? How great would that be\!

### Installation

{tidytitanic} is a real data package. So first let’s see how we’d use
it.

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("EvaMaeRey/tidytitanic")
```

### So, what can the package {tidytitanic} do for you?

Think about the API that you’d like to have for your package.

Since {tidytitanic} is a real package, we can look at that api. It
delivers flat data and uncounted data.

Let’s see how to use it …

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
#>     id class  sex   age survived
#> 3    1   3rd Male Child       No
#> 3.1  2   3rd Male Child       No
#> 3.2  3   3rd Male Child       No
#> 3.3  4   3rd Male Child       No
#> 3.4  5   3rd Male Child       No
#> 3.5  6   3rd Male Child       No
```

## Step 3. Build a data package\!

Let’s look ahead to the main work that has to be done in package
building before we begin.

### What’s inside, A. Prepping data

For this package, preparation happens in the `data-raw` folder, in a
file called `dataset_prep`.

``` r
prep <- readLines("data-raw/dataset_prep.R")
```

Quoting these here. It looks a lot like the data cleaning shown in our
‘Step 1’, the problem statement.

``` r
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
```

usethis::use\_data() on an object prepares a .rda file and saves it in
‘data’ folder.

### What’s inside, B. Making data available to package users.

Then we need to make data available to users. We do this in the R
folder, in a file called datasets\_export.

``` r
export <- readLines("R/dataset_export.R")
```

Quoting these here:

``` r
#' Records for individuals on titanic.
#'
#' A dataset with a row for each individual on the titanic
#'
#' @format A data frame with 2201 rows and 5 variables:
#' \describe{
#'   \item{id}{an arbitrary id for each individual}
#'   \item{class}{1st, 2nd, 3rd for each passenger}
#'   \item{sex}{Male, Female for each passenger}
#'   \item{age}{Child, Adult for each passenger}
#'   \item{survived}{No, Yes for each passenger}
#'   ...
#' }
#' @source A version of the Titanic data from the datasets package
"tidy_titanic"


#' Counts for combinations of characteristics of the individuals on the Titanic.
#'
#' A dataset with a row for each combination of characteristics of individuals on the Titanic.
#'
#' @format A data frame with 32 rows and 5 variables:
#' \describe{
#'   \item{class}{1st, 2nd, 3rd for each passenger}
#'   \item{sex}{Male, Female for each passenger}
#'   \item{age}{Child, Adult for each passenger}
#'   \item{survived}{No, Yes for each passenger}
#'   \item{freq}{count of individuals}

#'   ...
#' }
#' @source A version of the Titanic data from the datasets package
"flat_titanic"
```

-----

### What’s inside C. The rest of the architecture.

Ultimately you’ll have a fair number of files supporting the project.
I’m using fs::dir\_tree() to have a look at all the project files.

``` r
fs::dir_tree(recurse = T)
.
├── DESCRIPTION
├── LICENSE
├── LICENSE.md
├── NAMESPACE
├── R
│   └── dataset_export.R
├── README.Rmd
├── README.md
├── data
│   ├── flat_titanic.rda
│   └── tidy_titanic.rda
├── data-raw
│   └── dataset_prep.R
├── man
│   ├── flat_titanic.Rd
│   └── tidy_titanic.Rd
└── tidytitanic.Rproj
```

See details on how
[here](https://evamaerey.github.io/package_in_20_minutes/package_in_20_minutes#step-00-press-play-on-the-video-guide).
The good news is, you only have to edit ‘Description’, ‘readme.Rmd’ and
the files that have the .R extension (the two quoted above)\!

In this workshop, we’ll see that:

  - usethis::create\_package() helps us create the basic package
    architecture
  - devtools::document() creates the man folder and the .Rd files
  - usethis::use\_readme\_rmd() helps us create the readme file (then we
    ‘knit’ to create the .md version)
  - usethis::use\_data() on an object prepares a .rda file and saves it
    in ‘data’ … more to add…

## Step 4. Check and take your package for a spin\!

## Step 5. Done\! Celebrate\!

## Step 6. Think about outreach, CRAN, and futher development

Particularly impactful data packages usually do more to get the word out
about the work they do. In the package repository, more work and items
may be included to support this. Check out {palmerpenguins} and
{gapminder} to see this. You also might want to get your package on
CRAN\!
