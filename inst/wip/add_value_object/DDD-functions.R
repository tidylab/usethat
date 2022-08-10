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
    stopifnot(is.data.frame(obj))
    # usethis::use_package("tibble", type = "Imports")
    .add_value_object$generate_file(domain)

    obj_metadata <- .add_value_object$get_obj_metadata(obj)

    invisible()
}


# Low-level-functions -----------------------------------------------------
.add_value_object <- new.env()

.add_value_object$render_skeleton <- function(col_name, col_type, col_fun){
    str_glue("
           return(
            tibble::tibble()
           )
           ")
}

.add_value_object$get_obj_metadata <- function(x) {
    obj_metadata <- .add_value_object$get_col_name_and_type(x)
    tibble::add_column(obj_metadata, type_cast = paste0("as.", obj_metadata$col_type))
}

.add_value_object$get_col_name_and_type <- function(x) { return(
    x
    |> purrr::map_chr(~class(.x)[[1]])
    |> tibble::enframe("col_name", "col_type")
)}

.add_value_object$generate_file <- function(domain) {
    file <- .add_value_object$generate_file_name(domain = domain)

    if(!fs::file_exists(file)){
        fs::dir_create(dirname(file))
        fs::file_create(file)
    }
}

.add_value_object$generate_file_name <- function(domain) suppressMessages(
    if(is.null(domain)) {
        fs::path_wd("R", "value_objects", ext = "R")
    } else {
        fs::path_wd("R", paste0(domain, "-value_objects"), ext = "R")
    }
)

