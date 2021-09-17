.onAttach <- function(lib, pkg,...){#nocov start
    if(interactive()) packageStartupMessage(
            paste(
                "\n\033[44m\033[37m",
                "\nWelcome to usethat",
                "\nMore information, vignettes, and guides are available on the usethat package website:",
                "\nhttps://tidylab.github.io/usethat/",
                "\n\033[39m\033[49m",
                sep="")
    )
}#nocov end
