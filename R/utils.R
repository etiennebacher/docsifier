#' Transform string in snake case
#'
#' @param x String to transform
#'
#' @keywords internal
as_snake_case <- function(x) {

  x <- tolower(x)
  x <- gsub(" ", "_", x)
  return(x)

}


#' Detect if we are in a package environment or not
#' @keywords internal

is_it_a_package <- function() {

  if (file.exists("DESCRIPTION")) {

    x <- paste(readLines("DESCRIPTION"), collapse = " ")
    first_cond <- grepl("Type: Package", x)
    second_cond <- grepl("Package:", x)

    if (first_cond || second_cond) {
      is_package <- TRUE
    } else {
      is_package <- FALSE
    }

  } else {
    is_package <- FALSE
  }

  return(is_package)
}


#' Wrappers for cli messages
#' @param x Message (character vector)
#' @keywords internal

message_validate <- function(x) {
  cli::cat_bullet(
    bullet_col = "green", bullet = "tick",
    strwrap(prefix = " ", initial = "", x)
  )
}

#' @keywords internal
message_info <- function(x) {
  cli::cat_bullet(
    bullet_col = "red",
    strwrap(prefix = " ", initial = "", x)
  )
}

#' @keywords internal
message_error <- function(x) {
  strwrap(prefix = " ", initial = "", x)
}


#' Detect if the folder is empty
#'
#' @param x Name of the folder
#' @keywords internal

folder_is_empty <- function(x) {

  if (length(list.files(x)) == 0) {
    is_empty <- TRUE
  } else {
    is_empty <- FALSE
  }
  return(is_empty)

}








