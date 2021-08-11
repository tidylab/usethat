# Setup -------------------------------------------------------------------
path <- tempfile()
name <- "concierge"
withr::defer(unlink(path))


# Tests -------------------------------------------------------------------
test_that("use_microservice runs without errors",{
    expect_silent(use_microservice(path = path))
})

test_that("add_service runs without errors",{
    expect_null(add_service(path = path, name = name))
})
