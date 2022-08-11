#' @title Run Docker Commands
#'
#' @description
#' Run Docker Commands
#'
#' @keywords internal
#' @references \href{https://docs.docker.com/engine/reference/commandline/docker/}{The base command for the Docker CLI}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   docker <- Docker$new()
#' }
Docker <- R6::R6Class(classname = "Docker", cloneable = FALSE, lock_objects = FALSE, public = list(
    #' @description Instantiate a Docker object
    #' @param path (`character`) Path to a docker-compose file.
    #' @param stop_on_exit (`logical`) When the Docker instance is deleted, should its running containers stop?
    initialize = function(path = "./docker-compose.yml", stop_on_exit = TRUE) private$.initialize(path, stop_on_exit),
    #' @description Remove the Docker instance
    finalize = function() private$.finalize(),
    #' @description Check if Docker is installed
    is_docker_installed = function() private$.is_docker_installed(),
    #' @description Check if Docker is running
    is_docker_running = function() private$.is_docker_running()
))


# Private Methods ---------------------------------------------------------
Docker$set("private", ".initialize", function(path, stop_on_exit){
    assertthat::assert_that(assertthat::is.string(path))
    assertthat::assert_that(assertthat::is.flag(stop_on_exit))
    private$path <- normalizePath(path)
    private$stop_on_exit <- stop_on_exit

    private$check_system_status()
    private$services <- private$get_services(private$path)

})#.initialize

Docker$set("private", ".finalize", function(){
    if (private$.is_docker_running() & private$stop_on_exit) {
        cli::cli_alert_info("Stop containers")
    }
})#.finalize

Docker$set("private", ".is_docker_installed", function(){
    system <- purrr::partial(base::system, intern = TRUE)
    invisible(isTRUE(grep("Docker version", system("docker --version")) == 1))
})#.is_docker_installed

Docker$set("private", ".is_docker_running", function(){
    system <- purrr::partial(base::system, ignore.stderr = TRUE, ignore.stdout = TRUE)
    invisible(!isTRUE(system("docker stats --no-stream") == 1))
})#.is_docker_running


# Low-level Functions -----------------------------------------------------
Docker$set("private", "check_system_status", function(){
    if(isFALSE(private$.is_docker_installed())) {
        cli::cli_alert_warning("Docker is not installed")
    } else if (isFALSE(private$.is_docker_running())) {
        cli::cli_alert_warning("Docker is not running")
    } else {
        cli::cli_alert_success("Docker is installed and running")
    }
})

Docker$set("private", "get_services", function(path){
    paste_collapse <- eval(parse(text = 'purrr::partial(glue::glue_collapse, sep = ", ", last = " and ")'))
    services <- names(yaml::read_yaml(path, eval.expr = FALSE)$services)
    n_services <- length(services)
    cli::cli_alert_success("Found {cli::no(n_services)} service{?s}: {paste_collapse(services)}.")
    return(services)
})
