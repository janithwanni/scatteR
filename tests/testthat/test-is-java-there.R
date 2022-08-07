test_that("java is installed", {
  testthat::expect_equal(system2("java","-version"),0)
})
