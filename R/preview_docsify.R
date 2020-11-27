#' Preview the documentation in a webpage
#'
#' @export
preview_docsify <- function() {

  if (!isTRUE(install_docsify())) {
    "You need to install docsify first."
  }

  system("docsify serve docs --open")

}
