README <- new.env()

# remotes::install_cran(c("devtools", "desc", "usethis", "stringr"))

README$generate_shield_src <- function(label = "codecov", message = "0%", color = "red"){
    replace_symbols <- function(x){
        x <- gsub("%", "%25", x)
        x <- gsub(" ", "%20", x)
        x <- gsub("-", "--", x)
        x <- gsub("_", "__", x)
        return(x)
    }

    paste0("https://img.shields.io/badge/", replace_symbols(label), "-", replace_symbols(message), "-", color, ".svg")
}

README$getwd <- function(){
    candidates <- dirname(list.files(stringr::str_remove(getwd(), "(/tests/testthat|/tests)$|[^\\/]+tests$"), "^DESCRIPTION$", full.names = TRUE, recursive = TRUE))
    return(candidates[which.min(nchar(candidates))])
}
