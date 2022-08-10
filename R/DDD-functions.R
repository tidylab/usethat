#' @title Add Value Object
#'
#' @param obj (`data.frame`)
#' @param name (`character`)
#' @param domain (`character`)
#'
#' @family Domain-Driven Design
#' @return No return value, called for side effects.
#' @export
#'
#' @examples
#' \dontrun{
#'   add_value_object(obj = mtcars, name = "Car")
#' }
add_value_object <- function(obj, name, domain){
    file <- .add_value_object$generate_file_name(domain = domain)
    fs::dir_create(dirname(file))
    fs::file_create(file)

    invisible()
}


# Low-level-functions -----------------------------------------------------
.add_value_object <- new.env()

.add_value_object$generate_file_name <- function(domain) suppressMessages(
    if(is.null(domain)) {
        fs::path_wd("R", "value_objects", ext = "R")
    } else {
        fs::path_wd("R", paste0(domain, "-value_objects"), ext = "R")
    }
)
