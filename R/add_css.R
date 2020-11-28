#' Add a CSS file to your documentation
#'
#' @param name Name to give to the CSS file you want to create. If `NULL`, the file will be named `custom.css`
#'
#' @export

add_css <- function(name = NULL) {

  if (missing(name)) {
    name <- "custom"
  }
  if (!file.exists("docs/_assets/css")) {
    fs::dir_create("docs/_assets/css")
  }

  file_name <- paste0(name, ".css")

  if (file.exists(paste0("docs/_assets/css/", file_name)))
    stop(paste0("File ", file_name, " already exists."))

  fs::file_create(file.path("docs/_assets/css/", file_name))
  file.edit(file.path("docs/_assets/css/", file_name))
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    paste0('File "docs/_assets/css/', file_name, '" has been created.')
  )
  cli::cat_bullet(
    bullet_col = "red",
    paste0("Don't forget to add <link rel='stylesheet' href='/_assets/css/", file_name, "'/> in the head of 'index.html'")
  )
}
