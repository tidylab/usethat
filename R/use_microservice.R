#' @title Lay the Foundations of a Microservice
#' @description Generate boiler plate code for a microservice that works out-of-the-box.
#' @param entrypoint_name (`character`) Entrypoint name.
#' @param endpoint_name (`character`) Endpoint name.
#' @includeRmd vignettes/use_microservice.Rmd
#' @family use functions
#' @export
use_microservice <- function(entrypoint_name = "microservice", endpoint_name = "RESTful"){
    # Defensive Programming ---------------------------------------------------
    assert$is_character(entrypoint_name)
    assert$is_character(endpoint_name)

    # Setup -------------------------------------------------------------------
    file_paths <- list()
    file_paths["foreground"] <- file.path(getwd(), "inst", "entrypoints", paste0(entrypoint_name, "-foreground.R"))
    file_paths["background"] <- file.path(getwd(), "inst", "entrypoints", paste0(entrypoint_name, "-background.R"))
    file_paths["endpoint"]   <- file.path(getwd(), "inst", "endpoints",   paste0(endpoint_name, ".R"))
    invisible(sapply(file_paths, file.create))

    template <- list()
    template["foreground"] <- read_lines(find.template("templates", "microservice", "entrypoints", "plumber-foreground.R"))
    template["background"] <- read_lines(find.template("templates", "microservice", "entrypoints", "plumber-background.R"))
    template["endpoint"]   <- read_lines(find.template("templates", "microservice", "endpoints",   "RESTful.R"))

    # Add entrypoint ----------------------------------------------------------
    template[["foreground"]] %>%
        str_glue(name = endpoint_name) %>%
        write(file = file_paths[["foreground"]], append = FALSE, sep = "\n")

    template[["background"]] %>%
        str_glue(name = entrypoint_name) %>%
        write(file = file_paths[["background"]], append = FALSE, sep = "\n")

    # Add endpoint ------------------------------------------------------------
    template[["endpoint"]] %>%
        write(file = file_paths[["endpoint"]], append = FALSE, sep = "\n")

    # Return ------------------------------------------------------------------
    if(interactive()) sapply(file_paths, fs::file_show) # nocov
    invisible()
}
