withr::local_dir(path)

test_that("use_pipes copies template file to destination folder", {
    file_path <- file.path(getwd(), "temp", "utils-pipes.R")
    expect_null(use_pipes(path = "temp", export = TRUE))
    expect_true(file.exists(file_path))
    expect_match(read_lines(file_path), "export")
})

