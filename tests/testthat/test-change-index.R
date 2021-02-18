test_that("get_github_url works", {

  create_local_package()

  # NULL when no github url
  expect_null(get_github_url())

  # When only a URL
  cat("URL: https://github.com/etiennebacher/docsifier",
      file = "DESCRIPTION", append = T)
  expect_equal(
    get_github_url(),
    "https://github.com/etiennebacher/docsifier"
  )

  # When URL and bugreports
  cat("\nBugReports: https://github.com/etiennebacher/docsifier/issues",
      file = "DESCRIPTION", append = T)
  readLines("DESCRIPTION", warn = FALSE)
  expect_equal(
    get_github_url(),
    "https://github.com/etiennebacher/docsifier"
  )

})

test_that("get_pkg_name works", {

  create_local_package(dir = fs::path_temp("testpkg"))

  expect_equal(
    get_pkgname(),
    "testpkg"
  )

})
