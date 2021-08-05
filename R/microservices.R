# use_microservice --------------------------------------------------------
#' @inherit microservices::use_microservice title details return
#' @inheritParams microservices::use_microservice
#' @family microservice utilities
#' @export
#' @examples
#' path <- tempfile()
#' use_microservice(path)
#'
#' list.files(path, recursive = TRUE)
#'
#' cat(read.dcf(file.path(path, "DESCRIPTION"), "Imports"))
#' cat(read.dcf(file.path(path, "DESCRIPTION"), "Suggests"))
use_microservice <- microservices::use_microservice


# add_service -------------------------------------------------------------
#' @inherit microservices::add_service title details return
#' @inheritParams microservices::add_service
#' @family microservice utilities
#' @export
#' @examples
#' path <- tempfile()
#' dir.create(path, showWarnings = FALSE, recursive = TRUE)
#' use_microservice(path)
#'
#' add_service(path, name = "repository")
#'
#' list.files(path, recursive = TRUE)
add_service <- microservices::add_service

