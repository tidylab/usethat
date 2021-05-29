# define_na_class ---------------------------------------------------------
test_that("define simple NA object", {
  expect_s3_class(define_na_class(list(), "list"), "list")
})

test_that("define complex NA object", {
    expect_s3_class(
        define_na_class(.POSIXct(NA_real_, tz = "UTC"), c("POSIXct", "POSIXt")),
        c("POSIXct", "POSIXt")
    )
})


# Built-in NAs ------------------------------------------------------------
test_that("Built-in NAs exist", {
    expect_s3_class(NA_list_ , "list")
    expect_s3_class(NA_Date_ , "Date")
    expect_s3_class(NA_POSIXct_ , c("POSIXct", "POSIXt"))
})
