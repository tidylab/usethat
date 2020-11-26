suppressPackageStartupMessages(
    withr::with_dir(
        usethis::proj_get(),
        pkgload::load_all(export_all = !FALSE, helpers = FALSE, quiet = TRUE, warn_conflicts = FALSE)
    )
)

# global options ----------------------------------------------------------
options(tidyverse.quiet = TRUE)

# knitr -------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    out.width = '100%',
    echo = FALSE,
    results = "markup",
    message = FALSE,
    warning = FALSE,
    cache = !TRUE,
    comment = "#>",
    fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
    dpi = 300,
    out.width = "70%",
    fig.align = 'center',
    fig.width = 6,
    fig.asp = 0.618,  # 1 / phi
    fig.show = "hold",
    eval.after = 'fig.cap' # so captions can use link to demos
)

knitr::knit_hooks$set(
    error = function(x, options) {
        paste('\n\n<div class="alert alert-danger">',
              gsub('##', '\n', gsub('^##\ Error', '**Error**', x)),
              '</div>', sep = '\n')
    },
    warning = function(x, options) {
        paste('\n\n<div class="alert alert-warning">',
              gsub('##', '\n', gsub('^##\ Warning:', '**Warning**', x)),
              '</div>', sep = '\n')
    },
    message = function(x, options) {
        paste('\n\n<div class="alert alert-info">',
              gsub('##|#>', '\n', x),
              '</div>', sep = '\n')
    }
)

# helpers -----------------------------------------------------------------
read_snippet <- function(name) readLines(system.file("inst", "snippets", paste0(name,".R"), package = devtools::loaded_packages()[1,1]))

# rmarkdown ---------------------------------------------------------------
kable <- knitr::kable

