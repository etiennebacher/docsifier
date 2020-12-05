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
#' @importFrom utils file.edit
#' @export

use_docsify <- function(
  open = TRUE,
  add_reference = FALSE,
  include_internal = FALSE
) {

  ### Check whether the project is a package

  if (file.exists("DESCRIPTION")) {

    x <- readLines("DESCRIPTION")
    first_cond <- grep("Type: Package", x)
    second_cond <- grep("Package:", x)

    if (length(first_cond) == 0 && length(second_cond) == 0) {
      is_package <- FALSE
    } else {
      is_package <- TRUE
    }

  } else {
    is_package <- FALSE
  }

  ### Creates folder "docs"

  if (!file.exists("docs")) {
    fs::dir_create("docs")
    cli::cat_bullet(
      bullet_col = "green", bullet = "tick",
      'Folder "docs" has been created.'
    )
    if (isTRUE(is_package)) {
      cli::cat_bullet(
        bullet_col = "red",
        paste0('Folder "docs" is not standard in R packages. ', "Don't forget to add it in .buildignore.")
      )
    }
  } else {
    cli::cat_bullet(
      bullet_col = "red",
      'Folder "docs" is already present.'
    )
  }

  if (file.exists("docs/index.html")) {
    stop('"index.html" already exists. \n Please remove it before running use_docsify(). \n Nothing has been modified.')
  }

  ### Import examples of html and md in "docs"

  fs::file_copy(
    system.file("templates/index-template.html", package = "docsifier"),
    "docs/index.html"
  )
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    'File "index.html" has been created.'
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

  if (isTRUE(open)) {
    if (rstudioapi::isAvailable()) {
      invisible(lapply(
        c("docs/_sidebar.md", "docs/homepage.md",
          "docs/howto.md", "docs/index.html"),
        function(x) {
          rstudioapi::navigateToFile(x)
          return()
        }
      ))
    } else {
      file.edit(c("docs/_sidebar.md", "docs/homepage.md",
                  "docs/howto.md", "docs/index.html"))
    }
  }
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    'Files "homepage.md", "_sidebar.md", and "howto.md" have been created.'
  )


  ### Add a page with function references if user wants
  ### AND if the project is a package

  if (isTRUE(add_reference)) {
    if (fs::dir_exists("man")) {
      add_function_references(include_internal = include_internal)
    } else {
      stop('You need to create the folder "man" does not exist before adding a "Reference" page.')
    }
  }




}
