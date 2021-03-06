#' Add a section to _sidebar.md
#'
#' @param file Name of the file to copy in "docs"
#' @param name Name of the section or subsection to add
#' @param section_above Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.
#' @param type "section" or "subsection"
#'
#' @return Adds a section below all the other sections in _sidebar.md
#' @export

add_to_sidebar <- function(
  file,
  name,
  section_above = NULL,
  type = c("section", "subsection")
) {

  if (!file.exists(file)) stop(paste0("File ", file, " doesn't exist."))

  type <- match.arg(type)

  if (grepl("docs/", file)) {
    filename <- gsub("docs/", "", file)
  } else {
    filename <- file
  }
  # Markdown formatting differs with type (need to add an indent if
  # the type is subsection)
  if (type == "section") {
    line_to_add <- paste0("* [", name, "](", filename, ")")
  } else if (type == "subsection") {
    line_to_add <- paste0("  * [", name, "](", filename, ")")
  }

  if (is.null(section_above)) {
    # Strange behavior of cat(append = TRUE) so I do it manually
    text <- readLines("docs/_sidebar.md", warn = FALSE)
    text[length(text)+1] <- line_to_add
    cat(paste(text, collapse = "\n"), file = "docs/_sidebar.md")
  } else {
    insert_after(
      file = "docs/_sidebar.md",
      where = section_above,
      insert = line_to_add
    )
  }

  # Copy the file at the end so that it is not copied if there is a problem before
  if (!(grepl("docs/", file))) {
    fs::file_copy(path = file, new_path = paste0("docs/", file), overwrite = TRUE)
  }
}


#' Add the Code of Conduct, the License and the NEWS file as section or subsection
#' @param section_above Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.
#' @param type "section" or "subsection"
#' @export
#' @name add_sections

add_code_of_conduct <- function(section_above = NULL, type = "section") {
  if (file.exists("CODE_OF_CONDUCT.md")) {
    add_to_sidebar("CODE_OF_CONDUCT.md", "Code of Conduct",
                   section_above = section_above, type = type)
    message_validate("'Code of Conduct' section has been added.")
  } else {
    message_info(paste0("File CODE_OF_CONDUCT.md doesn't exist."))
  }
}

#' @export
#' @name add_sections

add_news <- function(section_above = NULL, type = "section") {
  if (file.exists("NEWS.md")) {
    add_to_sidebar("NEWS.md", "Changelog",
                   section_above = section_above, type = type)
    message_validate("'News' section has been added.")
  } else {
    message_info(paste0("File NEWS.md doesn't exist."))
  }
}

#' @export
#' @name add_sections

add_license <- function(section_above = NULL, type = "section") {
  if (file.exists("LICENSE.md")) {
    add_to_sidebar("LICENSE.md", "License",
                   section_above = section_above, type = type)
    message_validate("'License' section has been added.")
  } else if (file.exists("LICENCE.md")) {
    add_to_sidebar("LICENCE.md", "Licence",
                   section_above = section_above, type = type)
    message_validate("'License' section has been added.")
  } else {
    message_info(paste0("Files LICENSE.md and LICENCE.md don't exist."))
  }
}


#' Put README as homepage
#'
#' This function simply moves README.md in the docs and rename it "homepage.md". This is the only thing to do because homepage.md is defined as the .md file associated to "Home" in index.html.


readme_as_homepage <- function() {

  if (file.exists("README.md")) {

    fs::file_copy("README.md", "docs/homepage.md", overwrite = TRUE)
    replace_readme_img_paths()

    # Add the new section and remove the default line of template
    add_to_sidebar("docs/homepage.md", "Home",
                   section_above = "Home", type = "section")
    remove_from_sidebar("\\[Home\\]\\(/\\)", "docs/_sidebar.md")

    message_validate("The content of README.md has been put in homepage.md.")
    message_info("Don't forget to run `update_docsify()` if README.md changes.")

  }
}


remove_from_sidebar <- function(regex, file) {
  tmp <- readLines(file)
  tmp_new <- tmp[-which(grepl(regex, tmp))]
  writeLines(tmp_new, file)
}
