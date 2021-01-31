#' Create a Markdown (or R Markdown) file to populate your documentation.
#'
#' @param name Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.
#'
#' @param open Open or not the files created. Default is TRUE.
#'
#' @name add
#'
#' @export
#'
#' @return Creates a Markdown file in "docs".
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
#' init_docsify()
#'
#' # Create a new .md in "/docs"
#'
#' add_md("test")
#'
#' # Will output an error because "test.md" already exists
#'
#' add_md("test")
#' }
add_md <- function(name, open = TRUE) {

  if (missing(name)) stop("Must give a name to the .md file")
  if (name == "") stop("Must give a name to the .md file")
  if (!file.exists("docs")) {
    fs::dir_create("docs")
  }

  file_name <- paste0(name, ".md")
  file_path <- paste0("docs/", file_name)

  if (file.exists(paste0("docs/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file_path)

  if (isTRUE(open)) {
    if (rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(file_path)
    } else {
      utils::file.edit(file_path)
    }
  }

  message_validate(
    paste0('File "', file_name, '" has been created.')
  )

}

#' @rdname add
#' @export

add_rmd <- function(name, open = TRUE) {

  if (missing(name)) stop("Must give a name to the .md file")
  if (name == "") stop("Must give a name to the .md file")
  if (!file.exists("docs")) {
    fs::dir_create("docs")
  }

  file_name <- paste0(name, ".Rmd")
  file_path <- paste0("docs/", file_name)

  if (file.exists(paste0("docs/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file_path)

  if (isTRUE(open)) {
    if (rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(file_path)
    } else {
      utils::file.edit(file_path)
    }
  }

  message_validate(
    paste0('File "', file_name, '" has been created.')
  )

}


#' Add a CSS file to your documentation
#'
#' @param open Open or not the file created. Default is TRUE.
#' @param name Name to give to the CSS file you want to create. If `NULL`, the file will be named `custom.css`
#'
#'
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
#' init_docsify()
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

  message_validate(
    paste0('File "docs/_assets/css/', file_name, '" has been created.')
  )
  message_info(
    paste0("Don't forget to add <link rel='stylesheet' href='/_assets/css/", file_name, "'/> in the head of 'index.html'")
  )
}

