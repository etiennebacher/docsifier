#' Preview the documentation in a webpage or in viewer
#'
#' @export
preview_docsify <- function() {

  if (!fs::file_exists("docs/index.html")) {
    stop("index.html was not found. You can run use_docsify() to create it.")
  }

  servr::httw("docs/")

}
