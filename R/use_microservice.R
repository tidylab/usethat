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

    # Add entrypoint ----------------------------------------------------------
    file_paths <- list()
    file_paths["foreground"] <- file.path(getwd(), "inst", "entrypoints", paste0(entrypoint_name, "-foreground.R"))
    file_paths["background"] <- file.path(getwd(), "inst", "entrypoints", paste0(entrypoint_name, "-background.R"))
    invisible(sapply(file_paths, file.create))

    # template <- list()
    # template[1] <- read_lines(find.template("templates", "microservice", "plumber-foreground.R"))
    # template[2] <- read_lines(find.template("templates", "microservice", "plumber-background.R"))

    # Add endpoint ------------------------------------------------------------
    file_path <- file.path(getwd(), "inst", "endpoints", paste0(endpoint_name, ".R"))
    file.create(file_path)

    # template <- read_lines(find.template("templates", "value-object", "template.R"))
    # excerpts <- str_glue(template, name = name, domain = domain)
    #
    # excerpts %>%
    #     unlist(use.names = FALSE) %>%
    #     paste0(collapse = "\n\n") %>%
    #     write(file = file_path, append = FALSE, sep = "\n")
    #
    # if(interactive()) fs::file_show(file_path) # nocov

    # Return ------------------------------------------------------------------
    invisible()
}
