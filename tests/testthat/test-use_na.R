withr::local_dir(path)

test_that("use_na copies template file to destination folder", {
    file_path <- file.path(getwd(), "temp", "utils-na.R")
    expect_null(use_na(path = "temp", export = TRUE))
    expect_file_exists(file_path)
    expect_file_contains(file_path, "export")
})

