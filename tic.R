library(tic, warn.conflicts = FALSE)
source("./.dev/tic/helpers.R")

# Macros ------------------------------------------------------------------
# if (ci_on_ghactions() & is_master_branch()) do_pkgdown(deploy = TRUE, orphan = TRUE)
if (ci_on_ghactions()) do_pkgdown(deploy = TRUE, orphan = TRUE)

# Stage: Before Script ----------------------------------------------------
get_stage("before_script") %>%
    add_code_step(try(devtools::uninstall(), silent = TRUE))

# Stage: Script -----------------------------------------------------------
get_stage("script") %>%
    add_code_step(unlink(list.files(pattern = "demo-.*.R", full.names = TRUE, recursive = TRUE))) %>%
    check_package() %>%
    run_unit_tests() %>%
    run_code_coverage()

# Stage: After Success ----------------------------------------------------
get_stage("after_success")

# Stage: After Failure ----------------------------------------------------
get_stage("after_failure")

# Stage: Before Deploy ----------------------------------------------------
get_stage("before_deploy")

# Stage: Deploy -----------------------------------------------------------
# if (ci_on_ghactions() & is_master_branch())
if (ci_on_ghactions())
    get_stage("deploy") %>%
    add_step(step_publish_package_coverage())

# Stage: After Deploy -----------------------------------------------------
get_stage("after_deploy")

# Stage: After Script -----------------------------------------------------
get_stage("after_script")
