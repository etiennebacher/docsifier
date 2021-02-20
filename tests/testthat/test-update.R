test_that("update_docsify add files in folder 'docs'", {
  create_local_package()
  init_docsify(open = FALSE)
  expect_false(file.exists("docs/NEWS.md"))
  expect_false(file.exists("docs/LICENSE.md"))

  usethis::use_news_md(open = FALSE)
  usethis::use_mit_license()
  usethis::use_readme_md()
  update_docsify()

  expect_true(file.exists("docs/NEWS.md"))
  expect_true(file.exists("docs/LICENSE.md"))
  expect_equal(
    readLines("docs/homepage.md", warn = F),
    readLines("README.md", warn = F)
  )

})


test_that("update_* produce messages if files don't exist", {
  create_local_package()
  init_docsify(open = FALSE)

  expect_message(update_license())
  expect_message(update_news())
  expect_message(update_readme())
})

test_that("update_reference correctly add new references", {

  # Create package and import first Rd file
  create_local_package()
  dir_create("man")
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  file_copy(x, "man/example-doc.Rd")

  # Init, a unique function is added in reference
  init_docsify(open = FALSE, add_reference = TRUE)
  n_lines_before_update <- length(readLines("docs/reference.md"))

  # Add another Rd file, and update, so that reference should be longer now
  y <- system.file("templates/test-examples/example-doc-2.Rd",
                   package = "docsifier")
  file_copy(y, "man/example-doc-2.Rd")
  update_reference(include_internal = FALSE)
  n_lines_after_update <- length(readLines("docs/reference.md"))

  expect_true(n_lines_after_update > n_lines_before_update)

})
