#' Create a Markdown (or R Markdown) file to populate your documentation.
#'
#' @param name Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.
#'
#' @export
#'
#' @name add_md_rmd
#'
#' @examples
#' \dontrun{
#' # Create a new .md in "/docs"
#' add_md("test")
#'
#' # Will output an error because "test.md" already exists
#' add_md("test")
#' }
add_md <- function(name) {

  if (missing(name)) stop("Must give a name to the .md file")
  if (!file.exists("docs")) {
    fs::dir_create("docs")
  }

  file_name <- paste0(name, ".md")

  if (file.exists(paste0("docs/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file.path("docs/", file_name))
  file.edit(file.path("docs/", file_name))
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    paste0('File "', file_name, '" has been created.')
  )

}

#' @rdname add_md_rmd
#' @export

add_rmd <- function(name) {

  if (missing(name)) stop("Must give a name to the .Rmd file")
  if (!file.exists("docs")) {
    fs::dir_create("docs")
  }

  file_name <- paste0(name, ".Rmd")

  if (file.exists(paste0("docs/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file.path("docs/", file_name))
  file.edit(file.path("docs/", file_name))
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    paste0('File "', file_name, '" has been created.')
  )

}

