################################################################################
## plumber: Quick Start Guide
## <https://www.rplumber.io/index.html>
################################################################################
endpoint_path <- usethis::proj_path("inst", 'endpoints', '{endpoint_name}.R')
plumber <- plumber::Plumber$new(endpoint_path)
plumber$setDocsCallback(NULL)
plumber$run(host = 'localhost', port = "8080")
