#' Convert .Rmd files to give .md files
#'
#' Vignettes files (originally placed in the folder "Vignettes") have the output "html_vignette", which doesn't allow to produce the Markdown files needed for docsifier to work. This function makes several things:
#' * moves the .Rmd files from the "vignettes" folder in "docs/articles"
#' * replaces the "output chunk" of each .Rmd file (in "docs/articles") so that it is "md_document" instead of "html_vignette"
#' * render all of the modified .Rmd files (in "docs/articles"), which produce .md files.
#' @keywords internal

transform_vignettes <- function() {

  if (!file.exists("vignettes") || folder_is_empty("vignettes")) {
    message_info("No vignettes to transform.")
  } else {

    list_vignettes <- list.files("vignettes", pattern = ".Rmd")

    # Move vignettes to a custom folder so that I don't modify the original files
    if (!file.exists("docs/articles")) {
      fs::dir_create("docs/articles")
    }

    for (i in seq_along(list_vignettes)) {

      first_vignette <- paste0("vignettes/", list_vignettes[i])
      second_vignette <- paste0("docs/articles/", list_vignettes[i])

      if (vignettes_differ(first_vignette, second_vignette)) {

        fs::file_copy(
          first_vignette,
          second_vignette,
          overwrite = TRUE
        )

        original_vignette <- readLines(second_vignette, warn = FALSE)

        # Need to replace output and output options (i.e "output chunk")
        # by a .md output, so I detect the start and the end of output chunk.
        # The start is obvious, but for the end I detect the start of the vignette
        # chunk and then I take the line before.
        # This relies on the assumption that there's nothing between the output chunk
        # and the vignette chunk.
        start_of_output <- which(startsWith(original_vignette, "output:"))
        end_of_output <- which(startsWith(original_vignette, "vignette:")) - 1
        output_chunk <- original_vignette[start_of_output:end_of_output]

        # Remove output chunk and insert the new output
        modified_vignette <- original_vignette[-c(start_of_output:end_of_output)]
        modified_vignette[start_of_output] <- paste0(
          "output:\n  rmarkdown::github_document: \n    html_preview: false\n",
          modified_vignette[start_of_output]
        )
        modified_vignette <- paste(modified_vignette, collapse = "\n")
        cat(modified_vignette, file = second_vignette)

        # Store vignettes in .md format in "docs/articles"
        output_file <- paste0(
          substr(list_vignettes[i], 1, nchar(list_vignettes[i])-4),
          ".md"
        )

        rmarkdown::render(
          second_vignette,
          output_dir = "docs/articles",
          output_file = output_file,
          quiet = TRUE
        )

      }

    }

    message_validate("Vignettes have been converted to produce Markdown files.")
    message_validate("Markdown files have been produced and put in 'docs/articles'.")

  }

}


#' Insert the vignettes in sidebar
#'
#' This function creates the section "Articles" (or with another name) and puts all vignettes in "docs/articles" as subsections.
#'
#' @param section_name Name of the section containing the vignettes. Default is "Articles".
#' @param section_above Section below which the section "Articles" (or the name given in `section_name`) will be placed. By default, it will be placed just under "Home".
#'
#' @return Modifies "_sidebar.md" to insert the section containing the vignettes. Each vignette is a subsection.
#' @keywords internal

put_vignettes_in_sidebar <- function(
  section_name = "Articles",
  section_above = "Home"
) {

  if (!file.exists("docs/articles")) {
    stop(message_error("Need to create vignettes or to transform
                       them with transform_vignettes() first."))
  }

  sidebar_md <- readLines("docs/_sidebar.md", warn = FALSE)


  # Create section "Articles" in sidebar
  articles_in_sidebar <- grepl(
    paste0("* \\[", section_name, "\\]\\(/\\)"),
    paste(sidebar_md, collapse = "")
  )
  if (articles_in_sidebar == FALSE) {
    insert_after(
      file = "docs/_sidebar.md",
      where = section_above,
      insert = paste0("* [", section_name, "](/)")
    )
  }


  # Get articles info (title + name of the .md file they produce)
  list_of_articles <- list.files("docs/articles", pattern = ".Rmd")

  articles_info <- lapply(list_of_articles, function(x) {
    # Article title
    unquote_title(paste0("docs/articles/", x))
    content <- readLines(paste0("docs/articles/", x), warn = FALSE)
    line_with_title <- startsWith(content, "title:")
    title <- gsub(
      "title:",
      "",
      content[line_with_title]
    )
    title <- gsub(' \"', "", title)
    title <- gsub('\"', "", title)

    # .md file the article produces
    # Just have to remove .Rmd since all files in this loop are .Rmd
    md_file <- paste0("articles/", substr(x, 1, nchar(x)-4), ".md")

    return(list(title = title, md_file = md_file))
  })


  # Create the subsections
  subsections <- lapply(articles_info, function(x) {
        paste0("  * [", x$title, "](", x$md_file,")")
  })

  # Only new vignettes are added in "_sidebar.md"
  for (i in seq_along(subsections)) {
    x <- subsections[[i]]
    x <- gsub("\\(", "\\\\(", x)
    x <- gsub("\\)", "\\\\)", x)
    x <- gsub("\\[", "\\\\[", x)
    x <- gsub("\\]", "\\\\]", x)
    sub_in_sidebar <- grepl(substr(x, 4, nchar(x)), sidebar_md)
    if (TRUE %in% sub_in_sidebar) {
      subsections[[i]] <- NA
    }
  }
  new_subsections <- unlist(subsections[which(!is.na(subsections))])

  # Put the subsections in _sidebar.md
  if (!is.null(new_subsections)) {
    insert_after(
      file = "docs/_sidebar.md",
      where = "Articles",
      insert = new_subsections
    )
    message_info("Don't forget to reorder the articles if
               necessary in 'docs/_sidebar.md'.")
  } else {
    message_info("No new vignettes to add in sidebar.")
  }

}

#' Convert, move and insert vignettes
#'
#' @param section_name Name of the section containing the vignettes. Default is "Articles".
#' @param section_above Section below which the section "Articles" (or the name given in `section_name`) will be placed. By default, it will be placed just under "Home".
#'
#' @export

add_vignettes <- function(section_name = "Articles", section_above = "Home") {
  transform_vignettes()
  if (file.exists("docs/articles")) {
    put_vignettes_in_sidebar(section_name = section_name,
                             section_above = section_above)
  }
}




