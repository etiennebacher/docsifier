#' Create the structure to use docsify in an R package
#'
#' @param open Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.
#' @param readme_as_homepage Put the README as homepage? Default is TRUE.
#' @param add_vignettes Include vignettes as articles? Default is TRUE.
#' @param add_reference Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.
#' @param include_internal Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is FALSE See Details.
#' @param add_news Put NEWS as Changelog? Default is TRUE.
#' @param add_license,add_code_of_conduct Include License and Code of Conduct? Default is TRUE.
#'
#' @details TO FILL.
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
  readme_as_homepage = TRUE,
  add_vignettes = TRUE,
  add_reference = TRUE,
  include_internal = FALSE,
  add_news = TRUE,
  add_license = TRUE,
  add_code_of_conduct = TRUE
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

  fs::file_copy(
    system.file("templates/sidebar-template.md", package = "docsifier"),
    "docs/_sidebar.md"
  )

  fs::file_copy(
    system.file("templates/howto-template.md", package = "docsifier"),
    "docs/howto.md"
  )

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

  ### README as homepage
  if (isTRUE(readme_as_homepage)) {
    readme_as_homepage()
  }

  ### include function_reference/NEWS/LICENSE/CoC
  if (is_package) {
    if (isTRUE(add_reference)) {
      add_functions_reference(include_internal = include_internal)
    }
  }
  if (isTRUE(add_news)) {
    add_news()
  }
  if (isTRUE(add_license)) {
    add_license()
  }
  if (isTRUE(add_code_of_conduct)) {
    add_code_of_conduct()
  }
  if (isTRUE(add_vignettes)) {
    add_vignettes()
  }

  ### Change package name and github url in index.html
  change_pkgname_in_index()
  change_github_in_index()


}
