# misc --------------------------------------------------------------------
`%+%` <- base::paste0

# testthat ----------------------------------------------------------------
expect_class <- function(object, class) testthat::expect(any(base::class(object) %in% class), "object is" %+% base::class(object) %+% "not" %+% class)
expect_not_failure <- purrr::partial(testthat::expect_type, type = "environment")
expect_has_columns <- function(data, cols) testthat::expect(all(cols %in% colnames(data)), "not all column names are in the data.frame")
expect_file_exists <- function(path) testthat::expect(file.exists(path), "File doesn't exist at " %+% path)
expect_match <- function(object, regexp) testthat::expect_match(stringr::str_flatten(object, collapse = "\n"), regexp)

# devtools ----------------------------------------------------------------
create_package <- function(path){
    unlink(path, recursive = TRUE, force = TRUE)
    fs::dir_create(path)
    writeLines(c(
        "Package: dummy.package",
        "Title: What the Package Does (One Line, Title Case)",
        "Version: 0.0.0.9000",
        "Authors@R (parsed):",
        "    * First Last <first.last@example.com> [aut, cre] (YOUR-ORCID-ID)",
        "Description: What the package does (one paragraph).",
        "Encoding: UTF-8",
        "LazyData: true",
        "Roxygen: list(markdown = TRUE)",
        "RoxygenNote: 7.1.1",
        ""
    ), file.path(path, "DESCRIPTION"))
}
