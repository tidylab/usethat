#' @title Define New NA Class
#'
#' @param object ('?') An object which will have class attributes attached to it.
#' @param class ('character') The desired class of \code{object}.
#'
#' @return (`?`) The object of the desired class.
#' @export
#'
#' @examples
#'
#' NA_list_ <- structure(list(), class = "list")
#' NA_Date_ <- structure(NA_real_, class = "Date")
#' NA_POSIXct_ <- define_na_class(.POSIXct(NA_real_, tz = "UTC"), c("POSIXct", "POSIXt"))
#'
#' class(NA_list_)
define_na_class <- function(object, class){
    structure(.Data = object, class = class)
}
