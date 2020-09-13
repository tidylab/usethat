#' @title Add Command
#' @param name (`character`) Command name.
#' @param subdomain (`character`) Command sub-domain name.
#' @param testthat_exemption (`logical`) Should the function be excluded from unit-testing? see \code{testthat} ref.
#' @param covr_exemption (`logical`) Should the function be excluded from code-coverage? see \code{covr} ref.
#' @references
#' \href{https://testthat.r-lib.org/}{`testthat` package information}
#' \href{https://covr.r-lib.org/}{`covr` package information}
#' @family DDD
#' @export
add_command <- function(name, subdomain = NULL, testthat_exemption = FALSE, covr_exemption = testthat_exemption){
    stopifnot(
        is.character(name),
        is.null(subdomain) | is.character(subdomain),
        is.logical(testthat_exemption),
        is.logical(covr_exemption)
    )

    .add_command$script(name, subdomain, covr_exemption)
    if(!testthat_exemption) .add_command$test(name, subdomain)

    invisible()
}

# Low-lever Functions -----------------------------------------------------
.add_command <- new.env()
.add_command$script <- function(name, subdomain, covr_exemption){
    `%||%` <- function(a,b) if(is.null(a)) b else a
    slug <- .add_command$slug(name, subdomain)
    dir.create(usethis::proj_path("R"), recursive = TRUE, showWarnings = FALSE)

    start_comments <- ifelse(covr_exemption, "# nocov start", "")
    end_comments <- ifelse(covr_exemption, "# nocov end", "")

    content <- stringr::str_glue(stringr::str_replace_all(
        "
        ~ @title What the Function Does
        ~ @description `{fct_name}` is an amazing function
        ~ @param session (`environment`) A shared environment.
        ~ @return session
        ~ @family {subdomain} subdomain
        ~ @export
        {fct_name} <- function(session) {{ {start_comments}
            stopifnot(is.environment(session))
            attach(.{fct_name}, warn.conflicts = FALSE)
            on.exit(detach(.{fct_name}))

            # Code ...

            # Return
            invisible(session)
        }} {end_comments}
        .{fct_name} <- new.env()

        # Steps -------------------------------------------------------------------
        .{fct_name}$dummy_step <- function(...) NULL
        ", "~", "#'"),
        fct_name = name,
        subdomain = subdomain %||% "",
        start_comments = start_comments,
        end_comments = end_comments
    )

    writeLines(content, usethis::proj_path("R", slug, ext = "R"))
    invisible()
}

.add_command$test <- function(name, subdomain){
    dir.create(usethis::proj_path("tests", "testthat"), recursive = TRUE, showWarnings = FALSE)
    slug <- .add_command$slug(name, subdomain)
    writeLines(
        stringr::str_glue("
        context('unit test for {fct_name}')

        # Setup -------------------------------------------------------------------
        testthat::setup({{
            assign('test_env', testthat::test_env(), envir = parent.frame())
            test_env$session <- new.env()
        }})

        # General -----------------------------------------------------------------
        test_that('{fct_name} works', {{
            attach(test_env)
            expect_silent({fct_name}(session))
        }})
        ", fct_name = name),
        usethis::proj_path("tests", "testthat", paste0("test-", slug), ext = "R")
    )
    invisible()
}

.add_command$slug <- function(name, subdomain){
    is.not.null <- Negate(is.null)
    `%+%` <- base::paste0

    slug <- name
    slug <- if(is.not.null(subdomain)) subdomain %+% "-" %+% slug
    return(slug)
}
