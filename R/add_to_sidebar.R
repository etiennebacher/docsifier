#' Add a section to _sidebar.md
#'
#' @param filename Name of the file to add, must be a Markdown (.md) file
#' @param section_name Name of the section created with this file. If NULL, the name of the file is used.
#'
#' @return Adds a section below all the other sections in _sidebar.md
#' @export
#'
#' @keywords internal

add_to_sidebar <- function(
  section_name,
  subsection_name = NULL,
  subsection_md_file = NULL
  ) {

  section_name_nchar <- nchar(gsub(" ", "", section_name))
  if (section_name_nchar == 0) {
    stop("Need to provide a non-empty section name.")
  }

  sidebar_md <- readLines("docs/_sidebar.md", warn = FALSE)
  section_already_exists <- grepl(
    section_name,
    sidebar_md
  )
  if (TRUE %in% section_already_exists) {
    stop("There is already a section with this name.")
  }

  section_name_formatted <- paste0("* [", section_name, "]()\n")

  if (!is.null(subsection_name)) {
    subsection_name_formatted <- paste(
      "  * [", subsection_name, "]()",
      collapse = "\n", sep = ""
    )
  } else {
    subsection_name_formatted <- NULL
  }

  if (!is.null(subsection_name)) {
    section_and_subsection <- paste0(
      section_name_formatted,
      subsection_name_formatted
    )
  } else {
    section_and_subsection <- section_name_formatted
  }

  cat(section_and_subsection, file = "docs/_sidebar.md", append = TRUE)

}


#' Link a .md file to a section in _sidebar.md
#'
#' @param md_file Name of the .md file to link
#' @param section_name Name of the section to which link the .md file

link_md_to_section <- function(md_file, section_name) {

  # Need to be a .md file
  file_extension <- substr(md_file, nchar(md_file) - 2, nchar(md_file))
  if (file_extension != ".md")
    stop("The file must be a Markdown (.md) file.")

  # Get sidebar
  sidebar_md <- readLines("docs/_sidebar.md", warn = FALSE)

  # Need to be an existing section
  section_already_exists <- grepl(
    section_name,
    sidebar_md
  )
  if (!(TRUE %in% section_already_exists)) {
    stop("This section doesn't exist.")
  }

  # Need to be a section without .md file linked to it
  # section_name_formatted <- paste0("* [", section_name, "]()")
  # section_has_no_md <- unlist(lapply(sidebar_md, function(x) {
  #   identical(x, section_name_formatted)
  # }))
  # if (!(TRUE %in% section_has_no_md)) {
  #   stop("This section already has a .md file linked to it.")
  # }

  # Find the line to replace (i.e the line with a section but no .md file)
  line_to_replace <- which(section_already_exists)

  # create the right line
  if (startsWith(sidebar_md[line_to_replace], "  ")) {
    section_with_md <- paste0(
      "  * [", section_name, "](", md_file, ")"
    )
  } else {
    section_with_md <- paste0(
      "* [", section_name, "](", md_file, ")"
    )
  }

  # Replace the line and replace the file
  sidebar_md[line_to_replace] <- section_with_md
  cat(paste(sidebar_md, collapse = "\n"), file = "docs/_sidebar.md")

}


