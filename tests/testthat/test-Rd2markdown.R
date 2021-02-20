test_that("Rd2markdown needs a single file name", {
  expect_error(Rd2markdown())
  expect_error(
    Rd2markdown(c(testthat::test_path("examples", "example-doc.Rd"),
                  testthat::test_path("examples", "example-doc.Rd")))
  )
})

test_that("Rd2markdown works", {

  x <- Rd2markdown(testthat::test_path("examples", "example-doc.Rd"))
  expect_true(is.character(x))

  tmp <- fs::file_temp()
  cat(x, file = tmp)
  y <- readLines(tmp)

  z <- readLines(testthat::test_path("examples", "example-doc-correct.md"))

  expect_equal(y, z)

})
