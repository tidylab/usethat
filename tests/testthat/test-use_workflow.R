context("unit test for use_workflow")

# Setup -------------------------------------------------------------------
testthat::setup({
    assign("test_env", testthat::test_env(), envir = parent.frame())
    create_package(test_wd)
    withr::local_dir(test_wd, .local_envir = test_env)
})

# Create R script ---------------------------------------------------------
test_that("create an R script", {
    attach(test_env)
    name <- "order one pizza"
    domain <- "pizza ordering"
    expect_null(use_workflow(name, domain, n_step = 3))

    file_path <- file.path(getwd(), "inst", "workflows", "order-one-pizza.R")
    expect_file_exists(file_path)

    file_content <- readLines(file_path)
    expect_match(file_content, "step_1")
})
