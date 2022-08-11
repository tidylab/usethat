#' @title Run Docker Commands
#'
#' @keywords internal
#' @export
#' @examples
#' docker <- Docker$new()
Docker <- R6::R6Class(classname = "Docker", cloneable = FALSE, public = list(
    #' @description Instantiate a Docker Object
    initialize = function() private$.initialize()
), private = list(
    .initialize = function() stop("function not implemented")
))


# Private Methods ---------------------------------------------------------
Docker$set("private", ".initialize", overwrite = TRUE, function(){
    NULL
})#.initialize

