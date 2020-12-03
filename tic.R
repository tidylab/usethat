library(tic, warn.conflicts = FALSE)
source("./.dev/tic/helpers.R")

# Stage: Before Script ----------------------------------------------------
get_stage("before_script") %>%
    add_code_step(try(devtools::uninstall(), silent = TRUE)) %>%
    add_code_step(remotes::install_deps())

# Stage: Script -----------------------------------------------------------
(
    get_stage("script")
    %>% add_code_step(unlink(list.files(pattern = "demo-.*.R", full.names = TRUE, recursive = TRUE)))
    %>% add_step(step_rcmdcheck(error_on = "error"))
    %>% add_code_step(devtools::load_all(export_all = FALSE))
    %>% add_code_step(testthat::test_dir("./tests/testthat", stop_on_failure = TRUE))
    # %>% add_code_step(testthat::test_dir("./tests/integration", stop_on_failure = TRUE))
)

# Stage: After Success ----------------------------------------------------
get_stage("after_success")

# Stage: After Failure ----------------------------------------------------
get_stage("after_failure")

# Stage: Before Deploy ----------------------------------------------------
get_stage("before_deploy") %>%
    add_code_step(rmarkdown::render('README.Rmd', 'md_document'))

# Stage: Deploy -----------------------------------------------------------
if (ci_on_ghactions())
    get_stage("deploy") %>%
    add_step(step_publish_package_coverage())

# Stage: After Deploy -----------------------------------------------------
get_stage("after_deploy")

# Stage: After Script -----------------------------------------------------
get_stage("after_script")
