#' Add a Markdown file with function references
#'
#' @param include_internal Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is FALSE. See Details.
#'
#'
#' @details This function is automatically called with `init_docsify()` by default. However, if you didn't want to create it at the beginning but you changed your mind after having run `init_docsify()`, you can run it on its own.
#'
#' If you don't want to include internal functions (i.e functions that are not exported by the package), include "@@keywords internal" in the roxygen block of the function concerned, and use `include_internal = FALSE`.
#'
#' @return Creates a Markdown file called "reference.md" in the folder "docs", and edit "_sidebar.md" to add a "Reference" section.
#' @export
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
#' init_docsify(add_reference = FALSE)
#'
#' # Generate the "Reference" page in the documentation
#'
#' add_reference()
#' }

add_reference <- function(
  include_internal = FALSE,
  section_above = NULL,
  type = "section"
){

  list_man <- list.files("man/", pattern = ".Rd")
  list_man_md <- unlist(lapply(list_man, function(x) {
    Rd2markdown(rdfile = x, include_internal = include_internal)
  }))

  if (!fs::file_exists("docs/reference.md")) {
    fs::file_copy(
      system.file("templates/reference-template.md",
                  package = "docsifier"),
      "docs/reference.md"
    )
  } else {

    fs::file_copy(
      system.file(
        "templates/reference-template.md",
        package = "docsifier"
      ),
      "docs/reference.md",
      overwrite = TRUE
    )

  }

  # append the markdown text we made into the file
  cat(list_man_md, file = "docs/reference.md", append = TRUE)

  sidebar_md <- paste(readLines("docs/_sidebar.md", warn = FALSE),
                      collapse = "\n")
  if (!grepl("reference.md", sidebar_md)) {
    add_to_sidebar(
      file = "docs/reference.md",
      name = "Reference",
      section_above = section_above,
      type = type
    )
    message_validate("'Reference' section has been added.")
  } else {
    message_validate("'Reference' section has been updated.")
  }



}


