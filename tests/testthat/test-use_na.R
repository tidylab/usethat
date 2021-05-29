withr::local_dir(path)

test_that("use_na copies template file to destination folder", {
    expect_null(use_na())
    expect_true(file.exists(file.path(getwd(), "R", "utils-na.R")))
})
