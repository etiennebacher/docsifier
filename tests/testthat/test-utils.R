## Detect if project is a package

test_that("project is not considered as package", {
  create_local_project()
  expect_false(is_it_a_package())
})

test_that("package is considered as package", {
  create_local_package()
  expect_true(is_it_a_package())
})

## Detect if folder is empty

test_that("detect if folder is empty", {
  create_local_package()
  fs::dir_create("test")
  expect_true(folder_is_empty("test"))

  fs::file_create("test/file.R")
  expect_false(folder_is_empty("test"))
})

## Detect if string is quoted

test_that("detect if string is quoted", {
  expect_false(
    is_quoted("This is a string")
  )
  expect_true(
    is_quoted("'This is a string'")
  )
  expect_true(
    is_quoted('"This is a string"')
  )
})

## Unquote vignette title and compare vignettes

test_that("unquote_title removes the quotation marks", {

  # don't want to modify the file in examples so test on a temp file
  new_file <- fs::file_temp(ext = ".Rmd")
  fs::file_copy("examples/example-vignette.Rmd",
                new_file)

  original_content <- readLines(new_file, warn = FALSE)
  title <- gsub("title: ", "", original_content[2])
  expect_true(is_quoted(title))

  unquote_title(new_file)
  new_content <- readLines(new_file, warn = FALSE)
  title <- gsub("title: ", "", new_content[2])
  title <- gsub('\\"', "", title)
  expect_false(is_quoted(title))

})

test_that("vignettes_differ returns the right logical", {

  x <- "examples/example-vignette.Rmd"
  y <- "examples/example-vignette-2.Rmd"

  expect_false(
    vignettes_differ(x, x)
  )
  expect_true(
    vignettes_differ(x, y)
  )

})

## Deal with images path

test_that("get_img_paths returns the right output", {

  # No image path in the file
  expect_equal(
    length(get_img_paths("examples/example-vignette.Rmd")), 0
  )

  # With image path in the file
  expect_equal(
    get_img_paths("examples/example-readme.md"),
    "man/figures/logo.png"
  )

})

test_that("replace_img_paths returns the right output", {

  # don't want to modify the file in examples so test on a temp file
  new_file <- fs::file_temp(ext = ".md")
  fs::file_copy("examples/example-readme.md",
                new_file)
  new_file_name <- trimws(basename(new_file))
  new_file_name <- substr(new_file_name, 1, nchar(new_file_name) - 3)

  replace_img_paths(new_file)
  expect_equal(
    get_img_paths(new_file),
    paste0("_assets/img/", new_file_name, "_img/logo.png")
  )

})


## Insert text after line

test_that("insert_after returns the right output when added at the end of the file", {

  create_local_package()
  init_docsify(open = FALSE)

  original_content <- paste(readLines("docs/_sidebar.md", warn = FALSE), collapse = "")
  expect_equal(
    original_content,
    "<!-- homepage.md is defined as the first page in index.html  -->  * [Home](/)"
  )

  insert_after(
    file = "docs/_sidebar.md",
    where = "Home",
    insert = "* [Other section]"
  )
  new_content <- paste(readLines("docs/_sidebar.md", warn = FALSE), collapse = "")
  expect_equal(
    new_content,
    "<!-- homepage.md is defined as the first page in index.html  -->  * [Home](/)* [Other section]"
  )

})

test_that("insert_after returns the right output when added in the middle of the file", {

  create_local_package()
  init_docsify(open = FALSE)

  original_content <- paste(readLines("docs/_sidebar.md", warn = FALSE), collapse = "")
  expect_equal(
    original_content,
    "<!-- homepage.md is defined as the first page in index.html  -->  * [Home](/)"
  )

  insert_after(
    file = "docs/_sidebar.md",
    where = "defined",
    insert = "* [Other section]"
  )
  new_content <- paste(readLines("docs/_sidebar.md", warn = FALSE), collapse = "")
  expect_equal(
    new_content,
    "<!-- homepage.md is defined as the first page in index.html  -->  * [Other section]* [Home](/)"
  )

})
