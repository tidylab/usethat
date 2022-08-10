# utilities ---------------------------------------------------------------
line_break <- function() paste0("\n", paste0(rep("#", 80), collapse = ""))
banner <- function(title) paste0(line_break(), paste0("\n## ", title), line_break(), "\n", collapse = "")
read_lines <- function(path) paste(readLines(path), collapse = "\n")


# testthat ----------------------------------------------------------------
expect_not_failure <- purrr::partial(testthat::expect_type, type = "environment")
expect_no_error <- purrr::partial(testthat::expect_error, regexp = NA)


# utils -------------------------------------------------------------------
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

