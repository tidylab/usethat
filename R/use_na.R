#' @title Use NA of different classes in your project
#'
#' @description R has several built-in NA values that correspond to the atomic
#'   data types, such as `NA` (logical), `NA_integer_` and `NA_character_`.
#'   Calling `use_na()` allows the programmer to have NA values of any class. In
#'   addition, `use_na()` provides several useful NA values such as `NA_list_`,
#'   `NA_Date_` and `NA_POSIXct_`.
#'
#' @details The function copies a file with several NA values to
#'   '\code{path}/utils-na.R'.
#'
#' @param path (`character`) A path pointing at where to copy the file.
#' @param export If `TRUE`, the file different `NA` values in
#'   \code{path}/\code{utils-na.R} are exported to `NAMESPACE`.
#'
#' @return No return value, called for side effects.
#' @export
#' @examples
#' path <- tempfile()
#' use_na(path)
#' print(readLines(file.path(path, "utils-na.R")))
#'
use_na <- function(path = "R", export = TRUE){
    tags <- c("#' @rdname na_utiles", "#' @export")
    tags <- if(export) tags else tags[1]

    use_template(
        template = "misc/utils-na.R",
        save_as = file.path(path, "utils-na.R"),
        data = list(tags = paste0(tags, collapse = "\n")),
        open = FALSE
    )

    invisible()
}
