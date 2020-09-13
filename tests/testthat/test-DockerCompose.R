context("unit test for DockerCompose")

# Setup -------------------------------------------------------------------
testthat::setup({
    assign("test_env", testthat::test_env(), envir = parent.frame())
    test_env$path_dir <- tempfile("testthat-")
    test_env$path_yml <- file.path(test_env$path_dir, "docker-compose.yml")
    testthat::local_mock(
        system = function(...) invisible(),
        browseURL = function(...) invisible(),
        .local_envir = test_env
    )

    # Generate docker-compose.yml
    content <- list()
    content$services$dummyservices <- list(
        image = "dummy_image",
        container_name = "dummy-container",
        ports = "5050:3838"
    )

    dir.create(test_env$path_dir, showWarnings = FALSE, recursive = TRUE)
    yaml::write_yaml(content, test_env$path_yml)
})

# General -----------------------------------------------------------------
test_that("DockerCompose$new works", {
    expect_error(docker <- DockerCompose$new(tempfile()))
    expect_silent(docker <- DockerCompose$new(test_env$path_yml))
    expect_class(docker, "DockerCompose")
    test_env$docker <- docker
})

# Accessor Methods --------------------------------------------------------
test_that("DockerCompose$get works", {
    test_env$docker -> docker
    expect_identical(docker$get("dummyservices", "ports"), "5050:3838")
})

# Create and Start Containers ---------------------------------------------
test_that("DockerCompose$start works with all services", {
    test_env$docker -> docker
    expect_class(docker$start(), "DockerCompose")
})

test_that("DockerCompose$start works with specific services", {
    test_env$docker -> docker
    expect_class(docker$start("dummyservices"), "DockerCompose")
})

test_that("DockerCompose$start prompts an error for unknown services", {
    test_env$docker -> docker
    expect_error(docker$start("unknown_service"))
})

# Stop and Remove Containers ----------------------------------------------
test_that("DockerCompose$stop works", {
    test_env$docker -> docker
    expect_class(docker$stop(), "DockerCompose")
})

# Restart Containers ------------------------------------------------------
test_that("DockerCompose$restart works", {
    test_env$docker -> docker
    expect_class(docker$restart(), "DockerCompose")
})

# Reset Containers --------------------------------------------------------
test_that("DockerCompose$reset works", {
    test_env$docker -> docker
    expect_class(docker$reset(), "DockerCompose")
})

# browseURL ---------------------------------------------------------------
test_that("DockerCompose$browse_url works", {
    test_env$docker -> docker
    expect_silent(docker$browse_url(service = "dummyservices", slug = "sample-apps"))
})


