DeployShiny <- R6::R6Class(
    "DeployShiny",
    inherit = TicStep,
    public = list(
        # Public Methods -------------------------------------------------------
        initialize = function() remotes::install_cran(c("rsconnect", "yaml", "fs"), quiet = TRUE),
        run = function(){
            write_requirements <- DeployShiny$funs$write_requirements
            load_app_config <- DeployShiny$funs$load_app_config
            env_var_exists <- DeployShiny$funs$env_var_exists
            list_markdown <- DeployShiny$funs$list_markdown
            create_dir <- DeployShiny$funs$create_dir

            # Defensive Programming
            stopifnot(env_var_exists("SHINY_NAME"), env_var_exists("SHINY_TOKEN"), env_var_exists("SHINY_SECRET"))

            # Setup
            pkgload::load_all(path = ".", helpers = FALSE, quiet = TRUE)
            dashboard_source <- getOption("path_dashboard")
            dashboard_target <- file.path(tempdir(), "dashboard")
            package_source <- getwd()
            package_target <- file.path(dashboard_target, "package")

            create_dir(dashboard_target)
            fs::dir_copy(dashboard_source, dirname(dashboard_target))
            fs::dir_copy(package_source, package_target)
            fs::dir_delete(file.path(package_target, "inst", "dashboard"))
            fs::file_delete(list_markdown(package_target))
            write_requirements(package_target, dashboard_target)

            # Prepare Shiny
            load_app_config()
            rsconnect::setAccountInfo(
                name = Sys.getenv("SHINY_NAME"),
                token = Sys.getenv("SHINY_TOKEN"),
                secret = Sys.getenv("SHINY_SECRET")
            )

            # Deploy Shiny
            options(shiny.autoload.r = TRUE)
            rsconnect::deployApp(
                appDir = dashboard_target,
                appName = appName,
                appTitle = appTitle,
                account = Sys.getenv("SHINY_NAME"),
                forceUpdate = appForceUpdate
            )
        }
    )
)# end DeployShiny

step_deploy_shiny <- function() {
    DeployShiny$new()
}

# Helpers -----------------------------------------------------------------
DeployShiny$funs <- new.env()

DeployShiny$funs$env_var_exists = function(x) nchar(Sys.getenv(x)) > 0
DeployShiny$funs$load_app_config = function() list2env(yaml::yaml.load_file(list.files(".", "config-shiny.yml", full.names = TRUE, recursive = TRUE)[1], eval.expr = TRUE), globalenv())
DeployShiny$funs$list_markdown = function(path) list.files(path, ".(Rmd|md)$", full.names = TRUE, recursive = TRUE)
DeployShiny$funs$create_dir = function(x){unlink(x, recursive = TRUE, force = TRUE); dir.create(x, FALSE, TRUE)}
DeployShiny$funs$write_requirements <- function(package_path, dashboard_path){
    dependencies <-
        desc::desc_get_deps(file.path(package_path, "DESCRIPTION")) %>%
        dplyr::filter(type == "Imports") %>%
        .$package
    writeLines(paste0("library(", dependencies, ")"), file.path(dashboard_path, "requirements.R"))
    invisible()
}




