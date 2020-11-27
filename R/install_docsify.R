#' Install docsify
#'
#' @export
install_docsify <- function(){

  if (!node_available()) {
    stop("You need to install Node.js first.")
  }

  if (!npm_available()) {
    stop("You need to install npm first.")
  }

  ### Find how to install docsify locally (to avoid sudo)


  # temporary (needed for preview_docsify)
  return(TRUE)
}
