invisible(sapply(list.files("./.dev/tic", "^step_", full.names = TRUE), source))

# high level steps --------------------------------------------------------
build_steps <- check_package <- function(stage){
    stage %>%
        add_step(step_message(c(sep(), "\n## Build", sep()))) %>%
        add_code_step(devtools::document(quiet = TRUE)) %>%
        add_step(step_rcmdcheck(error_on = "error"))
}

test_suite_steps <- function(stage){
    stage %>%
        unit_test_steps() %>%
        component_test_steps()
}

run_unit_tests <- unit_test_steps <- function(stage){
    stage %>%
        add_step(step_message(c(sep(), "\n## Test: Unit-Tests", sep()))) %>%
        add_code_step(devtools::load_all(export_all = FALSE)) %>%
        add_code_step(testthat::test_dir("./tests/testthat", stop_on_failure = TRUE))
}

run_code_coverage <- function(stage){
    stage %>%
        add_step(step_message(c(sep(), "\n## Analyzing Code: Code-Coverage", sep()))) %>%
        add_code_step(print(covr::package_coverage(type = c("tests"), pre_clean = FALSE, quiet = FALSE)))
}

component_test_steps <- function(stage){
    if(dir.exists("./tests/component-tests"))
        stage <-
            stage %>%
            add_step(step_message(c(sep(), "\n## Test: Component-Tests", sep()))) %>%
            add_code_step(devtools::load_all(export_all = FALSE)) %>%
            add_code_step(testthat::test_dir("./tests/component-tests", stop_on_failure = TRUE))
    return(stage)
}


publish_code_coverage <- function(stage){
    stage %>%
        add_step(step_message(c(sep(), "\n## Publish Package Coverage Report", sep()))) %>%
        add_step(step_publish_package_coverage())
}

# branches wrappers -------------------------------------------------------
ci_is_ghactions <- function() nchar(Sys.getenv("GITHUB_ACTION")) > 0
ci_is_gitlab <- function() identical(Sys.getenv("CI_SERVER_NAME"), "GitLab")
ci_get_branch <- function() if(ci_is_gitlab()) Sys.getenv("CI_COMMIT_REF_NAME") else tic::ci_get_branch()
is_master_branch <- function() "master" %in% ci_get_branch()
is_develop_branch <- function() "develop" %in% ci_get_branch()
is_feature_branch <- function() grepl("feature", ci_get_branch())
is_hotfix_branch <- function() grepl("hotfix", ci_get_branch())
is_release_branch <- function() grepl("release", ci_get_branch())

# helper functions --------------------------------------------------------
ci_get_job_name <- function() tolower(paste0(Sys.getenv("TRAVIS_JOB_NAME"), Sys.getenv("APPVEYOR_JOB_NAME")))
sep <- function() paste0("\n", paste0(rep("#", 80), collapse = ""))
install_deps <- function(){
    build <- quiet <- FALSE
    try(remotes::install_deps(dependencies = "Depends",  build = build, quiet = quiet))
    try(remotes::install_deps(dependencies = "Imports",  build = build, quiet = quiet))
    try(remotes::install_deps(dependencies = "Suggests", build = build, quiet = quiet))
    return(invisible())
}
