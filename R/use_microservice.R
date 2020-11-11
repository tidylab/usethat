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
    file_paths["foreground"] <- file.path(getwd(), "inst",  "entrypoints", paste0(entrypoint_name, "-foreground.R"))
    file_paths["background"] <- file.path(getwd(), "inst",  "entrypoints", paste0(entrypoint_name, "-background.R"))
    file_paths["endpoint"]   <- file.path(getwd(), "inst",  "endpoints",   paste0(endpoint_name, ".R"))
    file_paths["unit_test"]  <- file.path(getwd(), "tests", "testthat",    paste0("test-endpoint-", endpoint_name, ".R"))
    invisible(sapply(file_paths, file.create))

    templates <- list()
    templates["foreground"] <- read_lines(find.template("templates", "microservice", "entrypoints", "plumber-foreground.R"))
    templates["background"] <- read_lines(find.template("templates", "microservice", "entrypoints", "plumber-background.R"))
    templates["endpoint"]   <- read_lines(find.template("templates", "microservice", "endpoints",   "RESTful.R"))
    templates["unit_test"]  <- read_lines(find.template("templates", "microservice", "tests",       "test-endpoint-plumber.R"))

    # Add entrypoint ----------------------------------------------------------
    templates[["foreground"]] %>%
        str_glue(name = endpoint_name) %>%
        write(file = file_paths[["foreground"]], append = FALSE, sep = "\n")

    templates[["background"]] %>%
        str_glue(name = entrypoint_name) %>%
        write(file = file_paths[["background"]], append = FALSE, sep = "\n")

    # Add endpoint ------------------------------------------------------------
    templates[["endpoint"]] %>%
        write(file = file_paths[["endpoint"]], append = FALSE, sep = "\n")

    # Add unit-test -----------------------------------------------------------
    if(is.not.testing())
        templates[["unit_test"]] %>% # nocov
        str_glue(name = endpoint_name) %>% # nocov
        write(file = file_paths[["unit_test"]], append = FALSE, sep = "\n") # nocov

    # Add suggested packages --------------------------------------------------
    description <- desc::description$new()
    description$set_dep("httptest", "Suggests", ">=3.3.0")
    description$set_dep("plumber",  "Suggests", ">=1.0.0")
    description$write()

    # Return ------------------------------------------------------------------
    if(interactive()) sapply(file_paths, fs::file_show) # nocov
    invisible()
}
