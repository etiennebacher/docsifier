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
