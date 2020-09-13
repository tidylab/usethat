#' @title Docker Commands Repository
#' @family Docker Classes
#' @export
Docker <- R6::R6Class(
    classname = "Docker",
    cloneable = FALSE,
    lock_objects = FALSE,
    public = list(
        #' @description Show running containers
        show_running_containers = function(){Docker$funs$show_running_containers(); invisible(self)},
        #' @description Show top level images, their repository, tags, and their size
        show_images = function(){Docker$funs$show_images(); invisible(self)},
        #' @description Remove layers that have no relationship to any tagged images
        remove_dangling_images = function(){Docker$funs$remove_dangling_images(); invisible(self)},
        #' @description Kill all running containers
        kill_all_containers = function(){Docker$funs$kill_all_containers(); invisible(self)},
        #' @description Kill a specific container
        #' @param container_name (`character`) container name
        kill_container = function(container_name){Docker$funs$kill_container(container_name); invisible(self)}
    )
)
Docker$funs <- new.env()

# Public Methods ----------------------------------------------------------
Docker$funs$kill_all_containers <- function()
    try(invisible(sapply(Docker$funs$get_containers_id(), Docker$funs$kill_container)), silent = TRUE)

Docker$funs$kill_container <- function(container_name)
    Docker$funs$system(stringr::str_glue("docker container kill {container_name}", container_name = container_name))

Docker$funs$get_containers_id <- function()
    Docker$funs$system("docker ps -q", intern = TRUE)

Docker$funs$remove_dangling_images <- function()
    Docker$funs$system("docker system prune", input = "y")

Docker$funs$show_images <- function()
    Docker$funs$system("docker images")

Docker$funs$show_running_containers <- function()
    Docker$funs$system("docker ps")

Docker$funs$show_all_containers <- function()
    Docker$funs$system("docker ps --all")

Docker$funs$make_name <- function(name)
    name %>% stringr::str_replace_all("\\.| ", "_") %>% stringr::str_to_lower()

# Helpers -----------------------------------------------------------------
Docker$funs$system <- function(command, ...){
    message("\033[43m\033[44m",command,"\033[43m\033[49m")
    base::system(command, ...)
}


# Wrapper -----------------------------------------------------------------
docker <<- Docker$new()
