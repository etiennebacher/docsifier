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
  cli::cli_alert_success(
    strwrap(prefix = " ", initial = "", x)
  )
}

#' @keywords internal
message_info <- function(x) {
  cli::cli_alert_info(
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



#' Obtain words between curly braces in .Rd files
#'
#' @param item Item to extract from the .Rd file. Can be any character vector among those between "\" and "\{" in a .Rd file. Use `NULL` to return all items between curly braces.
#'
#' @param text Text from which to extract.
#'
#' @keywords internal

get_in_text <- function(item, text) {

  text <- text

  # item to add in pattern is different when we're
  # looking for the item description. I want to keep the
  # item name clear when I call the function, so I replace
  # this item name by its necessary value. With this, I will be
  # able to call get_in_text('item_description', .)
  if (item == "argument_description")
    item <- "\\}"
  else if (item == "argument")
    item <- "item"


  # In the examples, there can be \donttest{}, \dontrun{},
  # or if (interactive()) {}. Therefore, the item we get depends
  # on the existence of one of this three things
  if (item == "examples") {
    if (isTRUE(grepl("\\\\donttest\\{", text))) {
      item <- "donttest"
    } else if (isTRUE(grepl("\\\\dontrun\\{", text))) {
      item <- "dontrun"
    } else if (isTRUE(grepl("if \\(interactive\\(\\)\\) \\{", text))) {
      item <- "if \\(interactive\\(\\)\\) "
    } else {
      item <- "examples"
    }

    # regex to get examples is very different than for others
    # so I put it also in the if condition

    if (item == "if \\(interactive\\(\\)\\) ") {
      pattern <- paste0(item, "({([^{}]*?(?:(?1)[^{}]*?)*)\\s*})")
    } else {
      pattern <- paste0("\\\\", item, "({([^{}]*?(?:(?1)[^{}]*?)*)\\s*})")
    }

    result <- regmatches(text, regexec(pattern, text, perl=TRUE))
    unlist(result)[3]

  } else {

    pattern <- paste0(item, "\\{\\K[^{}]+(?=\\})")
    result <- regmatches(text, gregexpr(pattern, text, perl=TRUE))
    result <- result[lapply(result, length) > 0]
    unlist(result)

  }

}


#' Check if vignettes in folder "vignettes" and in folder "docs/articles" differ
#'
#' Since the output of the vignette in the folder "vignette" is "html_vignette" and the output of the vignette in the folder "docs/articles" is "github_document", there will necessarily be changes. Therefore, the comparison is made on the files without the YAML.
#'
#' @param  x,y Names of the two vignettes to compare
#'
#' @return Boolean
#' @keywords internal

vignettes_differ <- function(x, y) {

  if (!file.exists(x) || !file.exists(y)) {
    return(FALSE)
  }

  x_file <- readLines(x, warn = FALSE)
  x_content <- gsub("---(.*?)---", "", paste(x_file, collapse = " "))

  y_file <- readLines(y, warn = FALSE)
  y_content <- gsub("---(.*?)---", "", paste(y_file, collapse = " "))

  if (!identical(x_content, y_content)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}



