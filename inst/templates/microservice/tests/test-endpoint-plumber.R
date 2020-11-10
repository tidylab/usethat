# context("unit test for {name} endpoint")
#
# # Setup -------------------------------------------------------------------
# testthat::setup({
#     ## Capture API Information
#     # httptest::.mockPaths(file.path(usethis::proj_get(), 'tests', 'api'))
#     # httptest::start_capturing()
#     # local_mock(with_mock_api = function(expr) eval(expr), .env = "httptest")
#     # GET <<- function(...) httptest::capture_requests(httr::GET(...))
#     # POST <<- function(...) httptest::capture_requests(httr::POST(...))
# })
#
# # healthcheck -------------------------------------------------------------
# httptest::with_mock_api({
#     test_that("healthcheck returns a success", {
#         url <- generate_url(config$host, config$port, "utility/healthcheck")
#         expect_status_200(GET(url))
#     })
# })
#
# # class -------------------------------------------------------------------
# httptest::with_mock_api({
#     describe("class", {
#         it("POST with character returns a character", {
#             input <- "Hello World!"
#             x <- jsonlite::toJSON(input, auto_unbox = TRUE)
#             url <- generate_url(config$host, config$port, "utility/class")
#             expect_status_200(response <- POST(url, body = x))
#
#             output <-
#                 extract_content_text(response) %>%
#                 jsonlite::fromJSON(flatten = TRUE) %>%
#                 stringr::str_remove_all('\"')
#             expect_match(output, "character")
#         })
#
#         it("POST with data.frame returns a data.frame", {
#             input <- mtcars
#             x <- jsonlite::toJSON(input, auto_unbox = TRUE)
#             url <- generate_url(config$host, config$port, "utility/class")
#             expect_status_200(response <- POST(url, body = x))
#
#             output <-
#                 extract_content_text(response) %>%
#                 jsonlite::fromJSON(flatten = TRUE) %>%
#                 stringr::str_remove_all('\"')
#             expect_match(output, "data.frame")
#         })
#     })
# })
#
# # Teardown ----------------------------------------------------------------
# testthat::teardown({httptest::stop_capturing()})
