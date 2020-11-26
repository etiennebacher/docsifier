#' Create the structure to use docsify in an R package
#'
#' @details This function creates the folder "/docs" if it doesn"t already exist, and "index.html" to create the documentation with docsify. The structure of "index.html" is automatically created and you can complete it with your custom info.
#'
#' You can use `add_md()` to add Markdown files in "/docs" to populate the documentation.

use_docsify <- function() {

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
  fs::file_copy(
    system.file("templates/md-template.md", package = "docsifier"),
    "docs/homepage.md"
  )
  file.edit(c("docs/homepage.md", "docs/index.html"))
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    'Files "index.html" and "homepage.md" have been created.'
  )


}
