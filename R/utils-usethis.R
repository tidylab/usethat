#' @noRd
#' @keywords internal
use_template <- function(
    template,
    save_as = template,
    data = list(),
    ignore = FALSE,
    open = FALSE,
    package = "usethat")
{
    dir.create(dirname(save_as), showWarnings = FALSE, recursive = TRUE)
    usethis::local_project(path = dirname(save_as), force = TRUE, setwd = FALSE)
    usethis::use_template(
        template = template,
        save_as = basename(save_as),
        data = data,
        ignore = ignore,
        open = open,
        package = package
    )

}
