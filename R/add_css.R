#' Add a CSS file to your documentation
#'
#' @param open Open or not the file created. Default is TRUE.
#' @param name Name to give to the CSS file you want to create. If `NULL`, the file will be named `custom.css`
#'
#' @importFrom utils file.edit
#' @export
#'
#' @return Creates a CSS file in "docs/_assets/css"
#'
#' @examples
#' \dontrun{
#'
#' library(docsifier)
#'
#' # Create a test folder and a test package for the example
#'
#' test_folder <- tempdir()
#' setwd(test_folder)
#' devtools::create("dummy")
#' setwd("dummy")
#'
#' # Generate the minimal documentation for docsify.js
#'
#' use_docsify()
#'
#' # Create "custom.css"  in "/docs/_assets/css"
#'
#' add_css()
#' }

add_css <- function(name = NULL, open = TRUE) {

  if (missing(name)) name <- "custom"
  if (name == "") name <- "custom"
  if (!file.exists("docs/_assets/css")) {
    fs::dir_create("docs/_assets/css")
  }

  file_name <- paste0(name, ".css")
  file_path <- paste0("docs/_assets/css/", file_name)

  if (file.exists(paste0("docs/_assets/css/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file_path)

  if (isTRUE(open)) {
    if (rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(file_path)
    } else {
      utils::file.edit(file_path)
    }
  }

  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    paste0('File "docs/_assets/css/', file_name, '" has been created.')
  )
  cli::cat_bullet(
    bullet_col = "red",
    paste0("Don't forget to add <link rel='stylesheet' href='/_assets/css/", file_name, "'/> in the head of 'index.html'")
  )
}
