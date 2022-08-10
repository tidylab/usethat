test_that("add_value_object creates a value object", {
    usethis::with_project(path = path, {
        expect_no_error(add_value_object(obj = mtcars, name = "Car", domain = NULL))
    })
})
