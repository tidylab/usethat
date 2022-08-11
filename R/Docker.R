#' @title Run Docker Commands
#'
#' @keywords internal
#' @references \href{https://docs.docker.com/engine/reference/commandline/docker/}{The base command for the Docker CLI}
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
))


# Private Methods ---------------------------------------------------------
Docker$set("private", ".initialize", overwrite = TRUE, function(){
    if(isFALSE(private$.is_docker_installed())) {
        cli::cli_alert_danger("Docker is not installed")
    } else if (isFALSE(private$.is_docker_running())) {
        cli::cli_alert_danger("Docker is not running")
    }
})#.initialize

Docker$set("private", ".is_docker_installed", overwrite = TRUE, function(){
    system <- purrr::partial(base::system, intern = TRUE)
    invisible(isTRUE(grep("Docker version", system("docker --version")) == 1))
})#.is_docker_installed

Docker$set("private", ".is_docker_running", overwrite = TRUE, function(){
    system <- purrr::partial(base::system, ignore.stderr = TRUE, ignore.stdout = TRUE)
    invisible(!isTRUE(system("docker stats --no-stream") == 1))
})#.is_docker_running
