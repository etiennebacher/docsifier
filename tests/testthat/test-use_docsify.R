### Basic files

test_that("use_docsify creates a new dir 'docs' if 'docs' doesn't exist", {
  create_local_package()
  use_docsify(open = FALSE, add_reference = FALSE)
  expect_true(dir_exists("docs"))
})

test_that("use_docsify creates the right files in 'docs'", {
  create_local_package()
  use_docsify(open = FALSE, add_reference = FALSE)
  expect_proj_file("docs/index.html")
  expect_proj_file("docs/homepage.md")
  expect_proj_file("docs/_sidebar.md")
  expect_proj_file("docs/howto.md")
})

test_that("use_docsify has an error if 'index.html' already exists", {
  create_local_package()
  dir_create("docs")
  file_create("docs/index.html")

})


### References

test_that("use_docsify has an error if creation of reference is asked but no 'man' folder", {
  create_local_package()
  expect_error(use_docsify(open = FALSE, add_reference = TRUE))
})

test_that("use_docsify creates a file for references if asked and if 'man' exists", {
  create_local_package()
  dir_create("man")
  use_docsify(open = FALSE, add_reference = TRUE)
  expect_proj_file("docs/func_reference.md")
})

test_that("user can create references after use_docsify", {
  create_local_package()
  dir_create("man")
  use_docsify(open = FALSE, add_reference = FALSE)
  add_function_references()
  expect_proj_file("docs/func_reference.md")
})

test_that("add_function_reference modifies '_sidebar.md", {
  create_local_package()
  dir_create("man")
  use_docsify(open = FALSE, add_reference = FALSE)

  # no reference section before calling add_function_references
  x <- readChar("docs/_sidebar.md", file.info("docs/_sidebar.md")$size)
  expect_false(grepl("* \\[Reference\\]\\(func_reference.md\\)", x))

  # reference section after
  add_function_references()
  y <- readChar("docs/_sidebar.md", file.info("docs/_sidebar.md")$size)
  expect_true(grepl("* \\[Reference\\]\\(func_reference.md\\)", y))
})

















