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

colnames(mtcars)

obj_attr <- function(x) { return(
    x
    |> purrr::map_chr(~class(.x)[[1]])
    |> tibble::enframe("col_name", "col_type")
)}

obj_attr(x = mtcars)

type_dic <- tibble::tribble(
    ~col_type, ~cast_fun,
    "numeric", "as.numeric",
    "double",  "as.double",
    "integer", "as.integer",
    "Date",    "as.Date",
    "POSIXct", "as.POSIXct",

)
