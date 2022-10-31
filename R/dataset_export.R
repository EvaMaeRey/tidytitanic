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
