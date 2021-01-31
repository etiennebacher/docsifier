# Projects

test_that("add_css creates 'custom.css' if no name provided", {
  create_local_project()

  add_css("", open = FALSE)
  expect_proj_file("docs/_assets/css/custom.css")
  file_delete("docs/_assets/css/custom.css")

  add_css(name = NULL, open = FALSE)
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

test_that("user must provide a name to add_md and add_rmd", {
  create_local_project()

  expect_error(add_md(open = FALSE))
  expect_error(add_rmd(open = FALSE))

  expect_error(add_md(name = "", open = FALSE))
  expect_error(add_rmd(name = "", open = FALSE))
})

test_that("add_md and add_rmd create the right files", {
  create_local_project()
  add_md("foo", open = FALSE)
  add_rmd("foo", open = FALSE)
  expect_proj_file("docs/foo.md")
  expect_proj_file("docs/foo.Rmd")
})

test_that("add_md and add_rmd cannot overwrite existing files", {
  create_local_project()
  add_md("foo", open = FALSE)
  add_rmd("foo", open = FALSE)
  expect_error(add_md("foo", open = FALSE))
  expect_error(add_rmd("foo", open = FALSE))
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

test_that("user must provide a name to add_md and add_rmd", {
  create_local_package()

  expect_error(add_md(open = FALSE))
  expect_error(add_rmd(open = FALSE))

  expect_error(add_md(name = "", open = FALSE))
  expect_error(add_rmd(name = "", open = FALSE))
})

test_that("add_md and add_rmd create the right files", {
  create_local_package()
  add_md("foo", open = FALSE)
  add_rmd("foo", open = FALSE)
  expect_proj_file("docs/foo.md")
  expect_proj_file("docs/foo.Rmd")
})

test_that("add_md and add_rmd cannot overwrite existing files", {
  create_local_package()
  add_md("foo", open = FALSE)
  add_rmd("foo", open = FALSE)
  expect_error(add_md("foo", open = FALSE))
  expect_error(add_rmd("foo", open = FALSE))
})
