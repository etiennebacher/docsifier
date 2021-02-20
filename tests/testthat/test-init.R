### Basic files

# Projects

test_that("init_docsify creates a new dir 'docs' if 'docs' doesn't exist", {
  create_local_project()
  init_docsify(open = FALSE)
  expect_true(dir_exists("docs"))
})

test_that("init_docsify creates the right files in 'docs'", {
  create_local_project()
  init_docsify(open = FALSE)
  expect_proj_file("docs/index.html")
  expect_proj_file("docs/homepage.md")
  expect_proj_file("docs/_sidebar.md")
  expect_proj_file("docs/docsify_files/docsify.min.js")
  expect_proj_file("docs/docsify_files/vue.min.css")
})

test_that("init_docsify has an error if 'index.html' already exists", {
  create_local_project()
  dir_create("docs")
  file_create("docs/index.html")
  expect_error(init_docsify(open = FALSE))
})


# Packages

test_that("init_docsify creates a new dir 'docs' if 'docs' doesn't exist", {
  create_local_package()
  init_docsify(open = FALSE)
  expect_true(dir_exists("docs"))
})

test_that("init_docsify creates the right files in 'docs'", {
  create_local_package()
  init_docsify(open = FALSE)
  expect_proj_file("docs/index.html")
  expect_proj_file("docs/homepage.md")
  expect_proj_file("docs/_sidebar.md")
  expect_proj_file("docs/docsify_files/docsify.min.js")
  expect_proj_file("docs/docsify_files/vue.min.css")
})

test_that("init_docsify has an error if 'index.html' already exists", {
  create_local_package()
  dir_create("docs")
  file_create("docs/index.html")
  expect_error(init_docsify(open = FALSE))
})

test_that("init_docsify adds 'docs' in .Rbuildignore if not already in", {
  create_local_package()

  x <- readChar(".Rbuildignore", file.info(".Rbuildignore")$size)
  expect_false(grepl("\\^docs\\$", x))

  init_docsify(open = FALSE)
  y <- readChar(".Rbuildignore", file.info(".Rbuildignore")$size)
  expect_true(grepl("\\^docs\\$", y))
})


### References

test_that("init_docsify has an error if creation of reference is asked but no 'man' folder", {
  create_local_package()
  expect_message(init_docsify(open = FALSE))
})

test_that("init_docsify creates a file for references if asked and if 'man' exists", {
  create_local_package()
  dir_create("man")
  init_docsify(open = FALSE)
  expect_proj_file("docs/reference.md")
})

test_that("user can create references after init_docsify", {
  create_local_package()
  dir_create("man")
  init_docsify(open = FALSE, add_reference = FALSE)
  add_reference()
  expect_proj_file("docs/reference.md")
})

test_that("add_function_reference modifies '_sidebar.md'", {
  create_local_package()
  dir_create("man")
  init_docsify(open = FALSE, add_reference = FALSE)

  # no reference section before calling add_reference
  x <- readChar("docs/_sidebar.md", file.info("docs/_sidebar.md")$size)
  expect_false(grepl("* \\[Reference\\]\\(reference.md\\)", x))

  # reference section after
  add_reference()
  y <- readChar("docs/_sidebar.md", file.info("docs/_sidebar.md")$size)
  expect_true(grepl("* \\[Reference\\]\\(reference.md\\)", y))
})

test_that("reference.md is correct ", {

  # Create package with an Rd file
  create_local_package()
  dir_create("man")
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  file_copy(x, "man/example-doc.Rd")

  # Init docsify and get the content of reference.md
  init_docsify(open = FALSE, add_reference = TRUE)
  y <- readLines("docs/reference.md", warn = F)
  y <- paste(y, collapse = "")

  # Get the right content
  z <- paste(readLines(system.file("templates/test-examples/example-doc-correct.md",
                             package = "docsifier"),
                 warn = F),
             collapse = ""
  )
  z <- paste0("# Reference", z)
  expect_equal(y, z)

})


### README as homepage

test_that("if readme exists, its content is put on homepage", {
  create_local_package()

  # Create a readme
  fs::file_create("README.md")
  cat("This is the content from the README file", file = "README.md", append = TRUE)

  init_docsify(open = FALSE)

  x <- suppressWarnings(readLines("README.md"))
  y <- suppressWarnings(readLines("docs/homepage.md"))
  expect_identical(x, y)

})


### Add NEWS.md

test_that("if news.md exists, it is included in the webpage", {
  create_local_package()

  # Create a News file
  fs::file_create("NEWS.md")
  cat("This is the content from the NEWS.md file", file = "NEWS.md", append = TRUE)

  init_docsify(open = FALSE)

  x <- suppressWarnings(readLines("NEWS.md"))
  y <- suppressWarnings(readLines("docs/NEWS.md"))
  expect_identical(x, y)

  sidebar_file <- suppressWarnings(readLines("docs/_sidebar.md"))
  news_in_sidebar <- grepl(
    "* [Changelog](NEWS.md)",
    sidebar_file,
    fixed = TRUE
  )
  expect_true(TRUE %in% news_in_sidebar)

})


### Add License

test_that("if license exists, it is included in the webpage", {
  create_local_package()

  fs::file_create("LICENSE.md")
  cat("This is the content from the LICENSE file", file = "LICENSE.md", append = TRUE)

  init_docsify(open = FALSE)

  x <- suppressWarnings(readLines("LICENSE.md"))
  y <- suppressWarnings(readLines("docs/LICENSE.md"))
  expect_identical(x, y)

  sidebar_file <- suppressWarnings(readLines("docs/_sidebar.md"))
  license_in_sidebar <- grepl(
    "* [License](LICENSE.md)",
    sidebar_file,
    fixed = TRUE
  )
  expect_true(TRUE %in% license_in_sidebar)

})

test_that("if license exists, it is included in the webpage", {
  create_local_package()

  fs::file_create("LICENCE.md")
  cat("This is the content from the LICENCE file", file = "LICENCE.md", append = TRUE)

  init_docsify(open = FALSE)

  x <- suppressWarnings(readLines("LICENCE.md"))
  y <- suppressWarnings(readLines("docs/LICENCE.md"))
  expect_identical(x, y)

  sidebar_file <- suppressWarnings(readLines("docs/_sidebar.md"))
  licence_in_sidebar <- grepl(
    "* [Licence](LICENCE.md)",
    sidebar_file,
    fixed = TRUE
  )
  expect_true(TRUE %in% licence_in_sidebar)

})

### Add CoC

test_that("if CoC exists, it is included in the webpage", {
  create_local_package()

  fs::file_create("CODE_OF_CONDUCT.md")
  cat("This is the content from the CODE_OF_CONDUCT file",
      file = "CODE_OF_CONDUCT.md", append = TRUE)

  init_docsify(open = FALSE)

  x <- suppressWarnings(readLines("CODE_OF_CONDUCT.md"))
  y <- suppressWarnings(readLines("docs/CODE_OF_CONDUCT.md"))
  expect_identical(x, y)

  sidebar_file <- suppressWarnings(readLines("docs/_sidebar.md"))
  license_in_sidebar <- grepl(
    "* [Code of Conduct](CODE_OF_CONDUCT.md)",
    sidebar_file,
    fixed = TRUE
  )
  expect_true(TRUE %in% license_in_sidebar)

})
