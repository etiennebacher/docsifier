# Function greatly inspired by the one in Colin Fay's article:
# https://colinfay.me/node-r-package/

#' Check if Node and npm are installed
#'
#' @export
npm_available <- function(){
  test <- suppressWarnings(
    system(
      "npm -v",
      ignore.stdout = TRUE,
      ignore.stderr = TRUE
    )
  )
  if (test != 0) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}
