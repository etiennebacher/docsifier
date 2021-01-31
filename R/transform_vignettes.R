#' Convert .Rmd files to give .md files
#'
#' Vignettes files (originally placed in the folder "Vignettes") have the output "html_vignette", which doesn't allow to produce the Markdown files needed for docsifier to work. This function makes several things:
#' * moves the "vignettes" folder in "docs/articles"
#' * replaces the "output chunk" of each .Rmd file so that it is "md_document" instead of "html_vignettes"
#' * render all of the .Rmd files (now modified), which produce .md files.
#' @keywords internal

transform_vignettes <- function() {

  if (!file.exists("vignettes") || folder_is_empty("vignettes")) {
    stop("No vignettes to transform.")
  }

  list_vignettes <- list.files("vignettes", pattern = ".Rmd")

  for (i in seq_along(list_vignettes)) {

    file_path <- paste0("vignettes/", list_vignettes[i])
    original_vignette <- readLines(file_path, warn = FALSE)

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
    cat(modified_vignette, file = file_path)

    # Store vignettes in .md format in "docs/articles"
    output_file <- paste0(
      substr(list_vignettes[i], 1, nchar(list_vignettes[i])-4),
      ".md"
    )
    rmarkdown::render(
      file_path,
      output_dir = "docs/articles",
      output_file = output_file,
      quiet = TRUE
    )

  }

  message_validate("Vignettes have been converted to produce Markdown files.")
  message_validate("Markdown files have been produced and put in 'docs/articles'.")

}


put_vignettes_as_section <- function(section_name = "Articles") {

  if (!file.exists("docs/articles")) {
    stop(message_error("Need to create vignettes or to transform
                       them with transform_vignettes() first."))
  }

  # Get articles names
  list_of_articles <- list.files("vignettes", pattern = ".Rmd")
  articles_names <- unlist(lapply(list_of_articles, function(x) {
    content <- readLines(paste0("vignettes/", x), warn = FALSE)
    line_with_title <- startsWith(content, "title:")
    title <- gsub(
      "title:",
      "",
      content[line_with_title]
    )
    title <- gsub(' \"', "", title)
    gsub('\"', "", title)
  }))

  # Get .md files names
  list_md_files <- list.files("docs/articles", pattern = ".md")

  # Create subsections with articles names
  add_to_sidebar(
    section_name = section_name,
    subsection_name = articles_names
  )

  # Link subsections to .md files
  for (i in seq_along(list_md_files)) {
    link_md_to_section(
      md_file = paste0("articles/", list_md_files[i]),
      section_name = articles_names[i]
    )
  }

}






