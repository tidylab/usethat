################################################################################
## plumber: Quick Start Guide
## <https://www.rplumber.io/index.html>
################################################################################
path <- usethis::proj_path("inst", 'entrypoints', '{name}-foreground.R')
rstudioapi::jobRunScript(
    path = path,
    name = "Plumber API", workingDir = ".",
    importEnv = TRUE,
    exportEnv = ""
)
