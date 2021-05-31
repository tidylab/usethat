#' @noRd
#' @keywords internal
use_template <- function(
    template,
    save_as = template,
    data = list(),
    ignore = FALSE,
    open = FALSE,
    package = "usethis2")
{
    withr::local_options(list(usethis.quiet = TRUE))
    wd <- getwd()
    withr::defer(usethis::proj_set(wd, force = TRUE))
    dir.create(dirname(save_as), showWarnings = FALSE, recursive = TRUE)
    usethis::proj_set(dirname(save_as), TRUE)

    usethis::use_template(
        template = template,
        save_as = basename(save_as),
        data = data,
        ignore = ignore,
        open = open,
        package = package
    )

}
