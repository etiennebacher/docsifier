#' Create a Markdown (or R Markdown) file to populate your documentation.
#'
#' @param name Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.
#'
#' @param open Open or not the files created. Default is TRUE.
#'
#' @name add_md_rmd
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
#' use_docsify()
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

#' @rdname add_md_rmd
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
