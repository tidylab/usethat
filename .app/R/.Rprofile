# Rporfile for CI/CD ------------------------------------------------------
#' When CI/CD starts, it replaces the .Rprofile of this repo (if any) with the
#' content of this file.

# First -------------------------------------------------------------------
.First <- function(){
    # Helpers
    get_repos <- function(){
        DESCRIPTION <- readLines("DESCRIPTION")
        Date <- trimws(gsub("Date:", "", DESCRIPTION[grepl("Date:", DESCRIPTION)]))
        URL <- if(length(Date) == 1) paste0("https://mran.microsoft.com/snapshot/", Date) else "https://cran.rstudio.com/"
        return(URL)
    }

    # Programming Logic
    ## .First watchdog
    if(file.exists(".git/First.lock")) return() else file.create(".git/First.lock", recursive = TRUE)

    ## Set global options
    options(startup.check.options.ignore = "stringsAsFactors")
    options(Ncpus = 8, repos = structure(c(CRAN = get_repos())), dependencies = c("Imports"), build = FALSE)
    .libPaths(Sys.getenv("R_LIBS_USER"))

    ## Install requirements
    if(!"remotes" %in% rownames(utils::installed.packages())) utils::install.packages("remotes", dependencies = getOption("dependencies"))
    remotes::install_github("ropenscilabs/tic@v0.6.0", dependencies = getOption("dependencies"), quiet = TRUE, build = FALSE)

    return(invisible())
}

# Last --------------------------------------------------------------------
.Last <- function(){
    unlink <- function(x) base::unlink(x, recursive = TRUE, force = TRUE)

    ## .First watchdog
    unlink(".git/First.lock")
}
