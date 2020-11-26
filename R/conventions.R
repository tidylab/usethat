# Naming Style ------------------------------------------------------------
#' @noRd
#' @keywords internal
#' @export
title <- new.env()
title$workflow <- purrr::partial(snakecase::to_snake_case, sep_out = "-")

# File Names --------------------------------------------------------------
#' @noRd
#' @keywords internal
#' @export
filename <- new.env()

filename$template <- function(entity = NULL, attribute = NULL, value = NULL){
    # NULL protection
    `%|>|%` <- function(a, b = identity){ if(is.null(a)) return(NULL) else return(b(a)) }


    paste0(paste(
        entity %|>|% snakecase::to_snake_case,
        attribute %|>|% snakecase::to_snake_case,
        value,
        sep = "-"
    ), ".R") %>%
        stringr::str_replace_all("--", "-") %>%
        stringr::str_remove_all("^-")
}

filename$workflow <- function(name = "unnamed", domain = "domain"){
    filename$template(NULL, NULL, title$workflow(name))
}

