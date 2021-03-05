.onAttach <- function(lib, pkg,...){#nocov start
    options(
        usethis.quiet = TRUE
    )

    try(
        packageStartupMessage(
            paste(
                "\n\033[44m\033[37m",
                "\nWelcome to usethis2",
                "\nMore information, vignettes, and guides are available on the usethis2 package website:",
                "\nhttps://tidylab.github.io/usethis2/",
                "\n\033[39m\033[49m",
                sep="")
        )
    )
}#nocov end
