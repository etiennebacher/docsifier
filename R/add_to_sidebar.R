#' Add a section to _sidebar.md
#'
#' @param file Name of the file to copy in "docs"
#' @param name Name of the section or subsection to add
#' @param section_above Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.
#' @param type "section" or "subsection"
#'
#' @return Adds a section below all the other sections in _sidebar.md
#' @export
#'
#' @keywords internal

add_to_sidebar <- function(file, name, section_above = NULL, type = "section") {

  if (!file.exists(file)) stop(paste0("File ", file, " doesn't exist."))

  # If add a section, append a line in _sidebar.md with the name of section
  # between brackets and the name of the file between parenthesis
  if (type == "section") {
    line_to_add <- paste0("* [", name, "](", file, ")")
  } else if (type == "subsection") {
    line_to_add <- paste0("  * [", name, "](", file, ")")
  }

  if (is.null(section_above)) {
    cat(line_to_add, file = "docs/_sidebar.md", append = TRUE)
  } else {
    insert_after(
      file = "docs/_sidebar.md",
      where = section_above,
      insert = line_to_add
    )
  }

  # Copy the file at the end so that it is not copied if there is a problem before
  if (!(grepl("docs/", file))) { # CONDITION NOT IDEAL BECAUSE IT CAN BE IN A
                           # SUBFOLDER OF DOCS
    fs::file_copy(path = file, new_path = paste0("docs/", file))
  }
}


#' Helpers for typical package files
add_code_of_conduct <- function() {
  if (file.exists("CODE_OF_CONDUCT.md")) {
    add_to_sidebar("CODE_OF_CONDUCT.md", "Code of Conduct")
  }
}
add_news <- function() {
  if (file.exists("NEWS.md")) {
    add_to_sidebar("NEWS.md", "Changelog")
  }
}
add_license <- function() {
  if (file.exists("LICENSE.md")) {
    add_to_sidebar("LICENSE.md", "License")
  } else if (file.exists("LICENCE.md")) {
    add_to_sidebar("LICENCE.md", "License")
  }
}



