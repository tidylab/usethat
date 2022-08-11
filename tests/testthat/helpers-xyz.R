# testthat ----------------------------------------------------------------
expect_no_error <- purrr::partial(testthat::expect_error, regexp = NA)
expect_file_exists <- function(file){ testthat::expect_true(file.exists(file), label = paste("There is no file at", file))}
expect_file_contains <- function(file, regexp, ...) {file_content <- paste(readLines(file), collapse = "\n"); testthat::expect_match(file_content, regexp, ...)}


# utilities ---------------------------------------------------------------
create_package <- function(path){
    unlink(path, recursive = TRUE, force = TRUE)
    dir.create(path, FALSE, TRUE)
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

