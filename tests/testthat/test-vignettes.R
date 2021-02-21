### First call for vignettes

test_that("transform_vignettes not running if no vignettes", {

  create_local_package()
  # folder vignettes does not exist
  expect_message(
    transform_vignettes(),
    regexp = "No vignettes to transform"
  )

  # folder vignettes is empty
  fs::dir_create("vignettes")
  expect_message(
    transform_vignettes(),
    regexp = "No vignettes to transform"
  )
})


test_that("transform_vignettes creates folder 'articles'", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = F)
  expect_false(file.exists("docs/articles"))
  transform_vignettes()
  expect_true(file.exists("docs/articles"))

})


test_that("transform_vignette does not affect the files in folder 'vignettes'", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  before_transform <- readLines("vignettes/example-vignette.Rmd", warn = F)

  init_docsify(open = F, add_vignettes = T)

  after_transform <- readLines("vignettes/example-vignette.Rmd", warn = F)

  expect_equal(before_transform, after_transform)
})


test_that("transform_vignette will produce a github md", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)

  new_content <- paste(
    readLines("docs/articles/example-vignette.Rmd", warn = F),
    collapse = ""
  )

  expect_true(grepl("github_document", new_content))
  expect_true(file.exists("docs/articles/example-vignette.md"))
})


test_that("transform_vignette does not affect the content of vignettes", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)

  # remove chunks and empty line
  original_content <- readLines("vignettes/example-vignette.Rmd", warn = F)
  original_content <- original_content[-c(1:15, length(original_content))]
  new_content <- readLines("docs/articles/example-vignette.Rmd", warn = F)[-c(1:14)]

  expect_equal(original_content, new_content)
})


test_that("section 'articles' is not created in sidebar if no vignettes exist", {

  create_local_package()
  init_docsify(open = F, add_vignettes = T)
  sidebar <- paste(
    readLines("docs/_sidebar.md"),
    collapse = ""
  )
  expect_false(grepl("Articles", sidebar))
  expect_false(grepl("erinaceous", sidebar))
})


test_that("section 'articles' created in sidebar", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)
  sidebar <- paste(
    readLines("docs/_sidebar.md", warn = F),
    collapse = ""
  )
  expect_true(grepl("Articles", sidebar))
})


test_that("subsection of 'articles' created in sidebar", {

  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)
  sidebar <- paste(
    readLines("docs/_sidebar.md", warn = F),
    collapse = ""
  )
  expect_true(grepl("erinaceous", sidebar))
})



### Update of vignettes

test_that("udpating vignettes does not create another section 'articles'", {

  # Init with a single vignette
  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)

  # update with another vignette
  fs::file_copy(
    system.file("templates/test-examples/example-vignette-2.Rmd",
                package = "docsifier"),
    "vignettes"
  )
  add_vignettes()


  sidebar <- paste(
    readLines("docs/_sidebar.md", warn = F),
    collapse = ""
  )

  expect_equal(
    length(grep("Articles", sidebar)),
    1
  )
})


test_that("subsection of 'articles' created in sidebar", {

  # Init with a single vignette
  create_local_package()
  fs::dir_create("vignettes")
  fs::file_copy(
    system.file("templates/test-examples/example-vignette.Rmd", package = "docsifier"),
    "vignettes"
  )
  init_docsify(open = F, add_vignettes = T)

  # update with another vignette
  fs::file_copy(
    system.file("templates/test-examples/example-vignette-2.Rmd",
                package = "docsifier"),
    "vignettes"
  )
  add_vignettes()

  # Check that both articles are in sidebar
  sidebar <- paste(
    readLines("docs/_sidebar.md", warn = F),
    collapse = ""
  )
  expect_true(grepl("erinaceous", sidebar))
  expect_true(grepl("philodox", sidebar))
})
