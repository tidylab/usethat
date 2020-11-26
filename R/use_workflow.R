#' @title Add a Workflow that Models a Domain
#' @description Create a **workflow** script with sequential steps.
#' @param name (`character`) **Workflow** name. Note: \code{workflow} applies
#'   naming convention automatically.
#' @param domain (`character`) sub-domain name. Note: \code{workflow} applies
#'   naming convention automatically.
#' @param n_step (`character`) Number of steps that constitute the **Workflow**.
#' @family use functions
#' @export
#' @includeRmd vignettes/use_workflow.Rmd
use_workflow <- function(name, domain, n_step = 3){
    assert$is_character(name)
    assert$is_character(domain)
    assert$is_count(n_step)


    # Acquire Templates -------------------------------------------------------
    template <- new.env()
    template$step <- read_lines(find.template("templates", "workflow", "step.R"))
    template$workflow <- data.frame(Step = paste0("step_", 1:n_step)) %>% str_glue_data('    {Step}()')
    template$skeleton <- read_lines(find.template("templates", "workflow", "skeleton.R"))


    # Render Templates --------------------------------------------------------
    script <- new.env()

    script$step <-
        paste0("step_", 1:n_step) %>%
        purrr::map(~ str_glue(template$step, name = .x)) %>%
        str_flatten()

    script$workflow <-
        paste0("session %>%\n", paste(template$workflow, collapse = " %>%\n"))

    script$skeleton <-
        template$skeleton %>%
        str_glue(
            name = title$workflow(name, domain),
            steps = script$step,
            workflow = script$workflow
        )


    # Export Script -----------------------------------------------------------
    file_path <- file.path(getwd(), "inst", "workflows", filename$workflow(name, domain))
    file.create(file_path)
    writeLines(script$skeleton, con = file_path)

    if(interactive()) fs::file_show(file_path) # nocov
    invisible()
}
