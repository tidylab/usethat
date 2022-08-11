#' @title Run Docker Commands
#'
#' @keywords internal
#' @export
#' @examples
#' docker <- Docker$new()
Docker <- R6::R6Class(classname = "Docker", cloneable = FALSE, public = list(
    #' @description Instantiate a Docker Object
    initialize = function() private$.initialize(),
    #' @description Check if Docker is installed
    is_docker_installed = function() private$.is_docker_installed(),
    #' @description Check if Docker is running
    is_docker_running = function() private$.is_docker_running()
), private = list(
    system_quietly = function(command, ...) base::system(command, ..., ignore.stderr = TRUE, ignore.stdout = TRUE)
))


# Private Methods ---------------------------------------------------------
Docker$set("private", ".initialize", overwrite = TRUE, function(){
    NULL
})#.initialize

Docker$set("private", ".is_docker_installed", overwrite = TRUE, function(){
    invisible(isTRUE(grep("Docker version", private$system_quietly("docker --version", intern = TRUE)) == 1))
})#.is_docker_installed

Docker$set("private", ".is_docker_running", overwrite = TRUE, function(){
    invisible(!isTRUE(private$system_quietly("docker stats --no-stream") == 1))
})#.is_docker_running
