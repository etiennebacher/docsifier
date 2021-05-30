#' Update files in docs
#'
#' @param include_internal Boolean indicating if internal functions should be included in the "Reference" page.
#'
#' @export
#'

update_docsify <- function(include_internal = FALSE) {

  ### Check whether the project is a package
  is_package <- is_it_a_package()

  if (is_package) {

    update_news()
    update_readme()
    update_license()
    update_reference(include_internal = include_internal)
    update_vignettes()

  }

}




#' Update a file in folder "docs"
#'
#' @param filename Name of the file which is up-to-date.
#' @param name_in_doc Name of the file to be updated in "docs".
#'
#' @return If file doesn't exist in "docs" then it is created. If file already exists in "docs", then it will overwrite it with the new version.
#'
#' @keywords internal
update_file <- function(filename, name_in_doc = NULL) {

  if (!file.exists(filename)) {
    message_info(paste0("File '", filename, "' doesn't exist."))
  } else {

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
      file_in_doc <- readLines(paste0("docs/", name_in_doc), warn = FALSE)
      file_up_to_date <- readLines(filename, warn = FALSE)

      if (!identical(file_up_to_date, file_in_doc)) {
        fs::file_copy(
          path = filename,
          new_path = paste0("docs/", name_in_doc),
          overwrite = TRUE
        )
      }
    }
  }

  # Change path for README images
  replace_readme_img_paths()

}


#' @keywords internal
update_readme <- function() {
  update_file("README.md")
  message_info("README updated.")
}

#' @keywords internal
update_news <- function() {
  update_file("NEWS.md")
  message_info("NEWS updated.")
}

#' @keywords internal
update_license <- function() {
  if (file.exists("LICENSE.md")) {
    update_file("LICENSE.md")
    message_info("LICENSE updated.")
  } else if (file.exists("LICENCE.md")) {
    update_file("LICENCE.md")
    message_info("LICENCE updated.")
  } else {
    message_info(paste0("No file 'LICENSE.md' or 'LICENCE.md' were found."))
  }

}

#' @keywords internal
update_reference <- function(include_internal) {
  add_reference(include_internal = include_internal)
  message_info("Reference updated.")
}

#' @keywords internal
update_vignettes <- function() {
  add_vignettes()
  message_info("Vignettes updated. Don't forget to check 'docs/sidebar.md'
               if you want to change the order.")
}
