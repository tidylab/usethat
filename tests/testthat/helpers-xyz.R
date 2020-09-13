# utilities ---------------------------------------------------------------
`%+%` <- base::paste0

# testthat ----------------------------------------------------------------
expect_class <- function(object, class) expect(any(base::class(object) %in% class), "object is" %+% base::class(object) %+% "not" %+% class)
expect_not_failure <- purrr::partial(testthat::expect_type, type = "environment")
