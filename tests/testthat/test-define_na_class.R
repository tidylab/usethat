test_that("define simple NA object", {
  expect_s3_class(define_na_class(list(), "list"), "list")
})

test_that("define complex NA object", {
    expect_s3_class(
        define_na_class(.POSIXct(NA_real_, tz = "UTC"), c("POSIXct", "POSIXt")),
        c("POSIXct", "POSIXt")
    )
})
