FROM rocker/shiny-verse:4.0.2

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure Shiny Server -------------------------------------------------------
#RUN rm -rf /srv/shiny-server/sample-apps
ARG SHINY_APP_NAME=sample-apps
RUN mkdir -p /srv/shiny-server/${SHINY_APP_NAME}
RUN chown shiny:shiny /srv/shiny-server/${SHINY_APP_NAME}
WORKDIR /srv/shiny-server/${SHINY_APP_NAME}

# Package Management System ----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-06-24\'
COPY ./DESCRIPTION /srv/shiny-server/${SHINY_APP_NAME}/DESCRIPTION
RUN R -q -e "if(!require(remotes)) install.packages('remotes', repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Depends',   repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports',   repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests',  repos = ${R_REPOS})"

# Prepare Dashboard Files ------------------------------------------------------
COPY . /srv/shiny-server/${SHINY_APP_NAME}/
RUN R -q -e "remotes::install_local(upgrade = 'never')"
RUN R -q -e "golem::add_shinyserver_file(open = FALSE)"
