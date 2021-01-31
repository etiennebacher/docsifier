#' Create the structure to use docsify in an R package
#'
#' @param open Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.
#' @param add_reference Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.
#' @param include_internal Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is TRUE. See Details.
#'
#' @details This function creates the folder "/docs" (if it doesn't already exist) and "index.html" to create the documentation with docsify.js. The structure of "index.html" is automatically created and you can complete it with your custom info.
#' You can use `add_md()` to add Markdown files in "/docs" to populate the documentation.
#'
#' You can add a page containing the list of functions that your package provide, and their documentation. Internal functions (i.e functions that are not exported by the package) are included by default. If you don't want to include them, add "@@keywords internal" in the roxygen block of the function concerned, and use `include_internal = FALSE`.
#'
#'
#' @export
#'
#' @return Creates a folder "docs" (if does not exist yet) and creates necessary files for docsify.js in it.
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
#' }

init_docsify <- function(
  open = TRUE,
  add_reference = TRUE,
  include_internal = FALSE,
  readme_as_homepage = TRUE,
  add_news = TRUE
) {

  ### Check whether the project is a package
  is_package <- is_it_a_package()

  ### Deal with folder "docs"
  if (!file.exists("docs")) {
    fs::dir_create("docs")
    message_validate('Folder "docs" has been created.')
  } else {
    if (!folder_is_empty("docs")) {
      stop(
        message_error("Folder 'docs' already exists and is not empty.
                      Please empty it before using docsifier. Nothing
                      has been modified.")
      )
    }
  }

  ### put docs in buildignore
  if (isTRUE(is_package)) {
    usethis::use_build_ignore("docs")
  }

  ### Import examples of html and md in "docs"

  fs::file_copy(
    system.file("templates/index-template.html", package = "docsifier"),
    "docs/index.html"
  )

  fs::file_copy(
    system.file("templates/homepage-template.md", package = "docsifier"),
    "docs/homepage.md"
  )

  if (isTRUE(add_reference)) {
    fs::file_copy(
      system.file("templates/sidebar-template2.md", package = "docsifier"),
      "docs/_sidebar.md"
    )
  } else {
    fs::file_copy(
      system.file("templates/sidebar-template.md", package = "docsifier"),
      "docs/_sidebar.md"
    )
  }

  fs::file_copy(
    system.file("templates/howto-template.md", package = "docsifier"),
    "docs/howto.md"
  )

  message_validate('File "index.html" has been created.')
  message_validate('Files "homepage.md", "_sidebar.md",
                    and "howto.md" have been created.')

  ### Open files or not
  if (isTRUE(open)) {
    if (rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(
        c("docs/_sidebar.md", "docs/homepage.md", "docs/howto.md", "docs/index.html")
      )
    } else {
      utils::file.edit(
        c("docs/_sidebar.md", "docs/homepage.md", "docs/howto.md", "docs/index.html")
      )
    }
  }


  ### Import the JS and CSS files
  if (!file.exists("docs/docsify_files")) {
    fs::dir_create("docs/docsify_files")
  }
  fs::file_copy(
    system.file("docsify/docsify.min.js", package = "docsifier"),
    "docs/docsify_files/docsify.min.js"
  )
  fs::file_copy(
    system.file("docsify/vue.min.css", package = "docsifier"),
    "docs/docsify_files/vue.min.css"
  )

  ### README as homepage
  if (isTRUE(readme_as_homepage)) {
    add_to_sidebar("README.md")
  }

  ### include NEWS
  if (isTRUE(add_news)) {
    add_to_sidebar("NEWS.md")
  }


  ### Add a page with function references if user wants
  ### AND if the project is a package

  if (isTRUE(add_reference)) {
    if (isTRUE(is_package)) {
      if (fs::dir_exists("man")) {
        add_function_references(include_internal = include_internal)
        message_validate('File "func_reference.md" has been created.')
      } else {
        stop('You need to create the folder "man" before adding a "Reference" page.')
      }
    } else {
      stop("You can only add functions reference in a package environment.")
    }

  }


}
