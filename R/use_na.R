#' @title Use NA of different classes in your project
#'
#' @description R has several built-in NA values that correspond to the atomic
#'   data types, such as `logical`, `integer` and `character`. Calling `use_na`
#'   allows the programmer to have NA values any class. In addition, `use_na`
#'   comes with several useful NA values such as `NA_list_`, `NA_Date_` and
#'   `NA_POSIXct_`.
#'
#' @details The function copies a file to '\code{path}/utils-na.R', which contains:
#'
#' * `define_na_class()` a helper function to construct NA of arbitrary classes.
#' * Several pre-defined NA values, such as `NA_list_` and `NA_Date_`.
#'
#' @param path (`character`) Path of file to copy.
#'
#' @return No return value, called for side effects.
#' @export
#'
#' @examples
#' use_na(path = tempdir())
#'
use_na <- function(path = "R"){
    usethis::use_template(
        template = "misc/utils-na.R",
        save_as = file.path(path, "utils-na.R"),
        open = FALSE,
        package = "usethis2"
    )
    invisible()
}
