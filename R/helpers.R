# nocov start
# predicates --------------------------------------------------------------
is.testing <- function() identical(Sys.getenv("TESTTHAT"), "true")
is.not.testing <- Negate(is.testing)

# base --------------------------------------------------------------------
find.template <- function(...){
    path <- base::system.file(..., package = "usethis2")
    if(nchar(path) == 0) path <- base::system.file("inst", ..., package = "usethis2", mustWork = TRUE)
    return(path)
}
read_lines <- function(con) base::readLines(con) %>% str_flatten()

# fs ----------------------------------------------------------------------
file.create <- function(path) {dir.create(dirname(path), F, T); fs::file_create(path)}

# tidyverse ---------------------------------------------------------------
str_flatten <- purrr::partial(stringr::str_flatten, collapse = "\n")
str_glue_data <- stringr::str_glue_data
str_glue <- stringr::str_glue
# nocov end
