# Built-in NAs ------------------------------------------------------------
test_that("Extra NAs exist", {
    expect_s3_class(NA_list_ , "list")
    expect_s3_class(NA_Date_ , "Date")
    expect_s3_class(NA_POSIXct_ , c("POSIXct", "POSIXt"))
})
