#' Create the structure to use docsify in an R package
#'
#' @param open Boolean indicating whether to open "index.html" and "homepage.md" following their creation.
#'
#' @details This function creates the folder "/docs" if it doesn"t already exist, and "index.html" to create the documentation with docsify. The structure of "index.html" is automatically created and you can complete it with your custom info.
#'
#' You can use `add_md()` to add Markdown files in "/docs" to populate the documentation.
#' @export

use_docsify <- function(open = TRUE) {

  ### Only works in a package

  if (file.exists("DESCRIPTION")) {
    x <- readLines("DESCRIPTION")[2]
    is_package <- grepl("Type: Package", x)
    if (is_package == FALSE) {
      stop("use_docsify only works if it is used in a package setup.")
    }
  } else {
    stop("use_docsify only works if it is used in a package setup.")
  }


  ### Creates folder "docs"

  if (!file.exists("docs")) {
    fs::dir_create("docs")
    cli::cat_bullet(
      bullet_col = "green", bullet = "tick",
      'Folder "docs" has been created.'
    )
  } else {
    cli::cat_bullet(
      bullet_col = "red",
      'Folder "docs" is already present.'
    )
  }


  ### Import examples of html and md in "docs"

  fs::file_copy(
    system.file("templates/index-template.html", package = "docsifier"),
    "docs/index.html"
  )
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    'Files "index.html" and "homepage.md" have been created.'
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
  if (isTRUE(open)) {
    file.edit(c("docs/_sidebar.md", "docs/homepage.md", "docs/howto.md", "docs/index.html"))
  }
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    'Files "homepage.md", "_sidebar.md", and "howto.md" have been created.'
  )


}
