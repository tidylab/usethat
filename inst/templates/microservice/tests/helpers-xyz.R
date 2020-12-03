# testthat ----------------------------------------------------------------
expect_has_columns <- function(df, cols) testthat::expect(all(cols %in% colnames(df)), "not all column names are in the data.frame")
expect_status_200 <- function(response){expect_is(response, "response"); expect_equal(response$status_code, 200L)}
expect_content_match <- function(response, regexp) expect_match(extract_content_text(response), regexp)
expect_content_is <- function(response, class) if(class == "image") expect_content_is_image(response, class) else expect_content_is_text(response, class)
expect_content_is_text <- function(response, class) expect_is(jsonlite::fromJSON(extract_content_text(response)), class)
expect_content_is_image <- function(response, class) expect_match(httr::http_type(response), "^image")

# httr and httptest -------------------------------------------------------
GET <- httr::GET
POST <- httr::POST
extract_content_text <- purrr::partial(httr::content, as = "text", encoding = "UTF-8")
mockPaths <- function(){
    path <- system.file("tests", "api", package = "anomaly.detector")
    if(nchar(path) == 0) path <- file.path("..", "api")
    httptest::.mockPaths(path)
}

# misc --------------------------------------------------------------------
generate_url <- function(host = "localhost", port = 8080, slug = "")
    stringr::str_glue("http://{host}:{port}/{slug}", host = host, port = port, slug = as.character(slug)) %>%
    URLencode()
