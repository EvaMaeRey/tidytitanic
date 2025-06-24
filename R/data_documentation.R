

#' Tallied characteristics
#'
#' A dataset tallying frequencies of titanic passenger characteristics based on Titanic data from datasets.  Includes Crew
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


#' 
#'
#' A dataset titanic passengers and characteristics based on Titanic data fromdatasets.  Includes Crew
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


#' Titanic test data.
#'
#' @format Data frame with columns
#' \describe{
#' \item{passenger_id}{Passenger ID}
#' \item{title}{Passenger title}
#' \item{last_name}{Passenger last name}
#' \item{first_name}{Passenger first name}
#' \item{survived}{survival status}
#' \item{pclass}{Passenger Class}
#' \item{sex}{Sex}
#' \item{age}{Age}
#' \item{sib_sp}{Number of Siblings/Spouses Aboard}
#' \item{parch}{Number of Parents/Children Aboard}
#' \item{fare}{Passenger Fare}
#' \item{cabin}{Cabin}
#' \item{embarked}{Port of Embarkation}
#' \item{ticket}{Ticket Number}
#' \item{maiden_name}{Maiden name}
#' \item{name}{Full name}
#' \item{prefered_name}{Prefered name}
#' 
#' 
#' ...
#' }
#' @source titanic package, https://www.kaggle.com/c/titanic/data
"passengers"
