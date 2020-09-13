#' Job Lifecycle
#'
#' 1. before_script
#' 2. script
#' 3. after_success or after_failure
#' 4. OPTIONAL before_deploy
#' 5. OPTIONAL deploy
#' 6. OPTIONAL after_deploy
#'
library(tic, warn.conflicts = FALSE)
source("./.app/tic/helpers.R")

# Stage: Before Script ----------------------------------------------------
get_stage("before_script") %>%
    add_code_step(install_deps()) %>%
    add_code_step(try(devtools::uninstall(), silent = TRUE))

# Stage: Script -----------------------------------------------------------
if(is_master_branch() | is_hotfix_branch()){
    get_stage("script") %>% build_steps() %>% test_suite_steps()
} else if (is_develop_branch() | is_release_branch()){
    get_stage("script") %>% build_steps() %>% test_suite_steps()

} else if (is_feature_branch()){
    get_stage("script") %>% test_suite_steps()
}

# Stage: After Success ----------------------------------------------------
get_stage("after_success")

# Stage: After Failure ----------------------------------------------------
get_stage("after_failure") %>%
    add_code_step(print(sessioninfo::session_info(include_base = FALSE)))

# Stage: Before Deploy ----------------------------------------------------
get_stage("before_deploy")

# Stage: Deploy -----------------------------------------------------------
get_stage("deploy") %>%
    publish_package_coverage()

# Stage: After Deploy -----------------------------------------------------
get_stage("after_deploy")

# Stage: After Script -----------------------------------------------------
get_stage("after_script")
