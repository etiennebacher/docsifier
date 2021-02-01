# Only in packages because need "man" folder

test_that("build_functions_reference cannot work without 'man' folder", {
  create_local_package()
  expect_error(build_functions_reference())
})

test_that("build_functions_reference cannot work without 'man' folder", {
  create_local_package()
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  dir_create("man")
  file_copy(x, "man/example-doc.Rd")
  y <- build_function_reference()
  expect_type(y, "list")
})

test_that("build_functions_reference cannot work without 'man' folder", {
  create_local_package()
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  dir_create("man")
  file_copy(x, "man/example-doc.Rd")
  y <- build_function_reference()

  lapply(y, function(z) {
    expect_type(class(z), "character")
  })
})

test_that("argument include_internal works when TRUE", {
  create_local_package()
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  x2 <- system.file("templates/test-examples/example-doc2.Rd",
                    package = "docsifier")
  dir_create("man")
  file_copy(x, "man/example-doc.Rd")
  file_copy(x2, "man/example-doc2.Rd")
  y <- build_function_reference(include_internal = TRUE)
  expect_equal(length(y), 2)
})

test_that("argument include_internal works when FALSE", {
  create_local_package()
  x <- system.file("templates/test-examples/example-doc.Rd",
                   package = "docsifier")
  x2 <- system.file("templates/test-examples/example-doc-internal.Rd",
                    package = "docsifier")
  dir_create("man")
  file_copy(x, "man/example-doc.Rd")
  file_copy(x2, "man/example-doc2.Rd")
  y <- build_function_reference(include_internal = FALSE)
  expect_equal(length(y), 1)
})
