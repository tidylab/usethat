PublishPackageCoverage <- R6::R6Class(
    "PublishPackageCoverage",
    inherit = TicStep,
    public = list(
        # Public Methods -------------------------------------------------------
        initialize = function() remotes::install_cran("covr", quiet = TRUE),
        run = function(){
            ci_on_gitlab <- function() identical(Sys.getenv("CI_SERVER_NAME"), "GitLab")
            ci_on_travis <- function() identical(Sys.getenv("TRAVIS"), "true")

            Sys.setenv(TESTTHAT = "true")
            on.exit(Sys.unsetenv("TESTTHAT"))

            coverage <- covr::package_coverage(type = c("tests"), pre_clean = FALSE, quiet = FALSE)
            print(coverage)

            if(ci_on_travis()){
                covr::codecov(coverage = coverage, quiet = FALSE)
            } else if (ci_on_gitlab()){
                covr::gitlab(coverage = coverage, quiet = FALSE)
            } else {
                stop("Unknown CI/CD service")
            }

            invisible()
        }# run()
    )# public
)# PublishPackageCoverage()

step_publish_package_coverage <- function() {
    PublishPackageCoverage$new()
}

# Helpers -----------------------------------------------------------------
PublishPackageCoverage$funs <- new.env()
