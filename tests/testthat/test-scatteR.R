test_that("scatteR catches Monotonic", {
  d <- scatteR(measurements = c("Monotonic" = 1),n_points = 25,init_points = 5)
  r <- scagnostics::scagnostics(d)
  print(r)
  expect_lte(abs(r["Monotonic"]-1.0),0.05)
})
