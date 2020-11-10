context("unit test for use_microservice")

# Setup -------------------------------------------------------------------
testthat::setup({
    assign("test_env", testthat::test_env(), envir = parent.frame())
    withr::local_dir(test_wd, .local_envir = test_env)
    test_env$entrypoint <- "plumber"
    test_env$endpoint <- "RESTful-API"
})

# Create R script ---------------------------------------------------------
test_that("create an R script", {
    attach(test_env)

    expect_null(use_microservice(entrypoint, endpoint))

    file_path <- usethis::proj_path("inst", "entrypoints", paste0(entrypoint, "-foreground"), ext = "R")
    expect_file_exists(file_path)
    # file_content <- readLines(file_path)
    # expect_match(file_content, entrypoint)

    file_path <- usethis::proj_path("inst", "entrypoints", paste0(entrypoint, "-background"), ext = "R")
    expect_file_exists(file_path)
    # file_content <- readLines(file_path)
    # expect_match(file_content, endpoint)

    file_path <- usethis::proj_path("inst", "endpoints", endpoint, ext = "R")
    expect_file_exists(file_path)

})
