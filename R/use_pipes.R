#' @title Use different pipes in your package
#'
#' @description
#'
#' The function adds the useful operators to use in your project. These
#' operators include:
#'
#' * `%>%` Forward Pipe operator
#' * `%||%` NULL operator
#'
#' @details
#'
#' The function:
#'
#' 1. Copies a file with several pipes '\code{path}/utils-pipes.R' and
#' 2. Imports the `purrr`package in the project DESCRIPTION file
#'
#' @inheritParams use_na
#' @return No return value, called for side effects.
#' @export
#' @examples
#' path <- tempfile()
#' use_pipes(path)
#' print(readLines(file.path(path, "utils-pipes.R")))
#'
use_pipes <- function(path = "R", export = TRUE){
    withr::local_options(list(usethis.quiet = TRUE))
    tags <- c("#' @rdname pipes", "#' @export")
    tags <- if(export) tags else tags[1]

    use_template(
        template = "misc/utils-pipes.R",
        save_as = file.path(path, "utils-pipes.R"),
        data = list(tags = paste0(tags, collapse = "\n")),
        open = FALSE
    )

    try(usethis::use_package("purrr", type = "Imports"))

    invisible()
}
