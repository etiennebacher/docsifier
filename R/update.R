#' Update a file in folder "docs"
#'
#' @param filename Name of the file which is up-to-date.
#' @param name_in_doc Name of the file to be updated in "docs".
#'
#' @return If file doesn't exist in "docs" then it is created. If file already exists in "docs", then it will overwrite it with the new version.
#'
#' @keywords internal
update_file <- function(filename, name_in_doc = NULL) {

  if (is.null(name_in_doc)) {
    name_in_doc <- filename
  }
  # Must be in different loop (not else if)
  if (filename == "README.md") {
    name_in_doc <- "homepage.md"
  }

  # Check if up-to-date file has the right extension
  file_extension <- substr(filename, nchar(filename) - 2, nchar(filename))
  if (file_extension != ".md")
    stop("The file must be a Markdown (.md) file.")

  # Check if to-be-updated file has the right extension
  name_in_doc_extension <- substr(
    name_in_doc,
    nchar(name_in_doc) - 2,
    nchar(name_in_doc)
  )
  if (name_in_doc_extension != ".md")
    stop("The file in documentation must be a Markdown (.md) file.")


  # If file not in doc, just have to create it
  if (!file.exists(paste0("docs/", name_in_doc))) {
    fs::file_copy(
      path = filename,
      new_path = paste0("docs/", name_in_doc)
    )
  }

  # If file in doc, have to replace it
  else {
    file_in_doc <- readLines(paste0("docs/", name_in_doc))
    file_up_to_date <- readLines(filename)

    usethis::ui_yeah(
      paste0("This will replace 'docs/",
             name_in_doc,
             "'. Are you sure you want to do it?"
      )
    )

    if (!identical(file_up_to_date, file_in_doc)) {
      fs::file_copy(
        path = filename,
        new_path = paste0("docs/", name_in_doc),
        overwrite = TRUE
      )
    }
  }

}


#' @export
update_readme <- function() {
  update_file("README.md")
}

#' @export
update_news <- function() {
  update_file("NEWS.md")
}
