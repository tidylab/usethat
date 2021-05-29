cat(banner("Unit Tests"))

path <- tempfile("test.")
usethis::create_package(path, open = FALSE)
