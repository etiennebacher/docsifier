# Projects

test_that("add_css creates 'custom.css' if no name provided", {
  create_local_project()

  add_css("", open = FALSE)
  expect_proj_file("docs/_assets/css/custom.css")
  file_delete("docs/_assets/css/custom.css")

  add_css(open = FALSE)
  expect_proj_file("docs/_assets/css/custom.css")
})

test_that("add_css creates the right file", {
  create_local_project()
  add_css("foo", open = FALSE)
  expect_proj_file("docs/_assets/css/foo.css")
})

test_that("add_css cannot overwrite existing files", {
  create_local_project()
  add_css("foo", open = FALSE)
  expect_error(add_css("foo", open = FALSE))
})




# Packages

test_that("add_css creates 'custom.css' if no name provided", {
  create_local_package()

  add_css("", open = FALSE)
  expect_proj_file("docs/_assets/css/custom.css")
  file_delete("docs/_assets/css/custom.css")

  add_css(open = FALSE)
  expect_proj_file("docs/_assets/css/custom.css")
})

test_that("add_css creates the right file", {
  create_local_package()
  add_css("foo", open = FALSE)
  expect_proj_file("docs/_assets/css/foo.css")
})

test_that("add_css cannot overwrite existing files", {
  create_local_package()
  add_css("foo", open = FALSE)
  expect_error(add_css("foo", open = FALSE))
})

