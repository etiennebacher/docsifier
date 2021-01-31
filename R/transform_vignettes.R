#' Convert .Rmd files to give .md files
#'
#' Vignettes files (originally placed in the folder "Vignettes") have the output "html_vignette", which doesn't allow to produce the Markdown files needed for docsifier to work. This function makes several things:
#' * moves the "vignettes" folder in "docs/vignettes"
#' * replaces the "output chunk" of each .Rmd file so that it is "md_document" instead of "html_vignettes"
#' * render all of the .Rmd files (now modified), which produce .md files.
#' @keywords internal

transform_vignettes <- function() {

  if (!file.exists("vignettes") || folder_is_empty("vignettes")) {
    stop("No vignettes to transform.")
  }
  fs::file_move("vignettes", "docs/vignettes")
  message_validate("Vignettes have been moved in 'docs/vignettes'.")

  list_vignettes <- list.files("docs/vignettes", pattern = ".Rmd")

  for (i in seq_along(list_vignettes)) {

    file_path <- paste0("docs/vignettes/", list_vignettes[i])
    original_vignette <- readLines(file_path)

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
      "output: rmarkdown::md_document \n", modified_vignette[start_of_output]
    )
    modified_vignette <- paste(modified_vignette, collapse = "\n")
    cat(modified_vignette, file = file_path)
    rmarkdown::render(file_path, quiet = TRUE)

  }

  message_validate("Vignettes have been converted.")
  message_validate("Markdown files have been produced.")

}
