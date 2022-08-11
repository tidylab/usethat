#' @title Run Docker Commands
#'
#' @description
#' Run Docker Commands
#'
#' @keywords internal
#' @references \href{https://docs.docker.com/engine/reference/commandline/docker/}{The base command for the Docker CLI}
#'
#' @importFrom assertthat assert_that
#' @export
#'
#' @examples
#' docker <- Docker$new()
Docker <- R6::R6Class(classname = "Docker", cloneable = FALSE, public = list(
    #' @description Instantiate a Docker object
    #' @param stop_on_exit (`logical`) When the Docker instance is deleted, should its running containers stop?
    initialize = function(stop_on_exit = TRUE) private$.initialize(stop_on_exit),
    #' @description Remove the Docker instance
    finalize = function() private$.finalize(),
    #' @description Check if Docker is installed
    is_docker_installed = function() private$.is_docker_installed(),
    #' @description Check if Docker is running
    is_docker_running = function() private$.is_docker_running()
), private = list(
    stop_on_exit = NA
))


# Private Methods ---------------------------------------------------------
Docker$set("private", ".initialize", overwrite = TRUE, function(stop_on_exit){
    assertthat::assert_that(assertthat::is.flag(stop_on_exit))
    private$stop_on_exit <- stop_on_exit

    if(isFALSE(private$.is_docker_installed())) {
        cli::cli_alert_danger("Docker is not installed")
    } else if (isFALSE(private$.is_docker_running())) {
        cli::cli_alert_danger("Docker is not running")
    } else {
        cli::cli_alert_success("Docker is installed and running")
    }
})#.initialize

Docker$set("private", ".finalize", overwrite = TRUE, function(){
    if (private$.is_docker_running() & private$stop_on_exit) {
        cli::cli_alert_info("Stop containers")
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
