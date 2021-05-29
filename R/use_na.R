#' @title Use NA of different classes in your project
#'
#' @description R has several built-in NA values that correspond to the atomic
#'   data types, such as `logical`, `integer` and `character`. Calling `use_na`
#'   allows the programmer to have NA values any class. In addition, `use_na`
#'   comes with several useful NA values such as `NA_list_`, `NA_Date_` and
#'   `NA_POSIXct_`.
#'
#' @details The function copies a file with several NA values to '\code{path}/utils-na.R'.
#'
#' @param path (`character`) Path of file to copy.
#'
#' @return No return value, called for side effects.
#' @export
#' @example
#' use_na(path = "R")
#' if(interactive()) browser(file.path(path, "utils-na.R"))
use_na <- function(path = "R"){
    dir.create(path, showWarnings = FALSE, recursive = TRUE)
    usethis::use_template(
        template = "misc/utils-na.R",
        save_as = file.path(path, "utils-na.R"),
        open = FALSE,
        package = "usethis2"
    )
    invisible()
}
