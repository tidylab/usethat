#' @title Various 'Not Available' / Missing Values
#' @description R comes with several built-in NA constants, including `NA`
#'   (logical), `NA_integer_`, `NA_real_`, `NA_complex_` and `NA_character_`.
#'   Similarly, we can define NA values that are associated with other classes,
#'   such as, `NA_Date_` and `NA_list_`.
#' @name na_utiles
#' @return Predefined constant.
NULL


# Atoms -------------------------------------------------------------------
{{tags}}
NA_numeric_ <- structure(NA_real_, class = c("integer", "numeric"))


# Timedate ----------------------------------------------------------------
{{tags}}
NA_Date_ <- structure(NA_real_, class = "Date")
{{tags}}
NA_POSIXct_ <- structure(.POSIXct(NA_real_, tz = "UTC"), class = c("POSIXct", "POSIXt"))


# Arrays ------------------------------------------------------------------
{{tags}}
NA_list_ <- structure(list(), class = "list")
{{tags}}
NA_data.frame_ <- structure(data.frame(), class = "data.frame")
