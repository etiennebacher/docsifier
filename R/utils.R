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


#' Insert a line in a text file
#'
#' @param file File in which insert a line
#' @param where After which line we want to insert some text
#' @param insert Text to insert
#' @keywords internal

insert_after <- function(file, where, insert) {

  # Import text
  text <- readLines(file, warn = FALSE)
  # Find the line after which we want to include text
  find_line <- which(
    grepl(where, text)
  )
  # Some important numbers
  n_lines_of_file <- length(text)
  n_lines_to_add <- length(insert)

  # Text currently below the line after which we want to include text
  text_below <- text[(find_line+1):(n_lines_of_file)]
  # Free enough space above this text
  text[(find_line+1+n_lines_to_add):(n_lines_of_file+n_lines_to_add)] <- text_below
  # Put the text to insert in the space now free
  text[(find_line+1):(find_line+n_lines_to_add)] <- insert

  # Write text in file
  cat(paste(text, collapse = "\n"), file = file)

}








