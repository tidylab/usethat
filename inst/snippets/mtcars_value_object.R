# add_value_object(obj, name)

head(mtcars)


mpg <- mtcars$mpg
cyl <- mtcars$cyl
disp <- mtcars$disp

(
    tibble::tibble(mpg = mpg)
    |> tibble::add_column(cyl = cyl)
    |> tibble::add_column(disp = disp)
)

# withr::with_options(list(usethis.quiet = TRUE), usethis::use_package("tibble", type = "Imports"))
usethis::use_package("tibble", type = "Imports")
usethis::
