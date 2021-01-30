#' Add a section to _sidebar.md
#'
#' @param filename Name of the file to add, must be a Markdown (.md) file
#' @param section_name Name of the section created with this file. If NULL, the name of the file is used.
#'
#' @return Adds a section below all the other sections in _sidebar.md
#' @export
#'
#' @keywords internal

add_to_sidebar <- function(filename, section_name = NULL) {

  if (!file.exists(filename))
    stop(paste0("'", filename, "' doesn't exist."))

  # No section name provided => section name is file name
  if (is.null(section_name)) {
    section_name <- filename
  }

  file_extension <- substr(filename, nchar(filename) - 2, nchar(filename))
  if (file_extension != ".md")
    stop("The file must be a Markdown (.md) file.")

  # Section name is section_name minus the .md extension
  section <- paste0(
    "* [", substr(section_name, 1, nchar(section_name) - 3),
    "](", filename, ")"
  )
  section_already_exists <- grepl(section, "docs/sidebar.md")

  if (section_already_exists == FALSE) {
    if (filename != "README.md") {
      cat(section, file = "docs/_sidebar.md", append = TRUE)
    }
  }

  mod_section_name <- as_snake_case(section_name)
  update_file(filename, name_in_doc = section_name)

}


#' Update a file in folder "docs"
#'
#' @param filename Name of the file which is up-to-date.
#' @param name_in_doc Name of the file to be updated in "docs".
#'
#' @return If file doesn't exist in "docs" then it is created. If file already exists in "docs", then it will overwrite it with the new version.
#' @export
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


update_readme <- function() {
  update_file("README.md")
}

update_news <- function() {
  update_file("NEWS.md")
}




#' Transform string in snake case
#'
#' @param x String to transform
#'
#' @keywords internal
as_snake_case <- function(x) {

  x <- tolower(x)
  x <- gsub(" ", "_", x)
  return(x)

}


#' Detect if we are in a package environment or not

is_it_a_package <- function() {

  if (file.exists("DESCRIPTION")) {

    x <- paste(readLines("DESCRIPTION"), collapse = " ")
    first_cond <- grepl("Type: Package", x)
    second_cond <- grepl("Package:", x)

    if (first_cond || second_cond) {
      is_package <- TRUE
    } else {
      is_package <- FALSE
    }

  } else {
    is_package <- FALSE
  }

  return(is_package)
}


#' Wrappers for cli messages
#' @param x Message (character vector)

message_validate <- function(x) {
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    strwrap(prefix = " ", initial = "", x)
  )
}

message_info <- function(x) {
  cli::cat_bullet(
    bullet_col = "red",
    strwrap(prefix = " ", initial = "", x)
  )
}

message_error <- function(x) {
  strwrap(prefix = " ", initial = "", x)
}


#' Detect if the folder is empty
#'
#' @param x Name of the folder

folder_is_empty <- function(x) {

  if (length(list.files(x)) == 0) {
    is_empty <- TRUE
  } else {
    is_empty <- FALSE
  }
  return(is_empty)

}








