test_that("add_value_object creates a value object", {
    obj <- mtcars
    name <- "Car"
    domain <- NULL

    usethis::with_project(path = path, {
        expect_null(add_value_object(obj = obj, name = name, domain = domain))
        expect_file_exists(usethis::proj_path("R", "value_objects", ext = "R"))
    })
})
