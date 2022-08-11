# Setup -------------------------------------------------------------------
file.copy(system.file("templates", "docker", "docker-compose.yml", package = "usethat", mustWork = TRUE), path)


# Tests -------------------------------------------------------------------
test_that("Docker works", {
    expect_no_error(docker <- Docker$new(file.path(path, "docker-compose.yml")))
    expect_no_error(docker$is_docker_installed())
    expect_no_error(docker$is_docker_running())
    skip_if_not(docker$is_docker_running(), "Docker is not running")
})
