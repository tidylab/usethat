test_that("Docker works", {
    expect_no_error(docker <- Docker$new())
    expect_no_error(docker$is_docker_installed())
    expect_no_error(docker$is_docker_running())
    skip_if_not(docker$is_docker_running(), "Docker is not running")
})
