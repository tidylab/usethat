# R Package Development: Testing------------------------------------------------
FROM r/core/package:4.0.0
RUN touch .Renviron .Rprofile

# Setup Continuous Integration (CI) System -------------------------------------
#ARG TIC_VER='0.7.0'
#RUN R -q -e "remotes::install_github('ropensci/tic@v$(eval echo $TIC_VER)', upgrade = FALSE)"

# Prepare Package Files --------------------------------------------------------
ARG R_USER=./home/rstudio/
ARG R_PACKAGE_NAME=rproject
COPY . ${R_USER}/${R_PACKAGE_NAME}
RUN cp .Rprofile ${R_USER}/${R_PACKAGE_NAME}
RUN cp .env ${R_USER}/.Renviron
WORKDIR ${R_USER}/${R_PACKAGE_NAME}

# Test-Suite -------------------------------------------------------------------
RUN R -q -e "devtools::check(error_on = 'error')"
RUN R -q -e "system.time({\
               devtools::load_all(export_all = FALSE, helpers = FALSE);\
               testthat::test_dir('./tests/testthat', stop_on_failure = TRUE)\
             })"

# Teardown ---------------------------------------------------------------------
ENTRYPOINT /bin/bash
