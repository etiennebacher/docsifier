# Detect if we are in a package environment or not
# @keywords internal

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


# Wrappers for cli messages
# @param x Message (character vector)
# @keywords internal

message_validate <- function(x) {
  cli::cli_alert_success(
    strwrap(prefix = " ", initial = "", x)
  )
}

# @keywords internal
message_info <- function(x) {
  cli::cli_alert_info(
    strwrap(prefix = " ", initial = "", x)
  )
}

# @keywords internal
message_error <- function(x) {
  strwrap(prefix = " ", initial = "", x)
}


# Detect if the folder is empty
#
# @param x Name of the folder
# @keywords internal

folder_is_empty <- function(x) {

  if (length(list.files(x)) == 0) {
    is_empty <- TRUE
  } else {
    is_empty <- FALSE
  }
  return(is_empty)

}


# Insert a line in a text file
#
# @param file File in which insert a line
# @param where After which line we want to insert some text
# @param insert Text to insert
# @keywords internal

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
  if (find_line < n_lines_of_file) {
    text_below <- text[(find_line+1):(n_lines_of_file)]
  } else if (find_line == n_lines_of_file) {
    text_below <- NULL
  }

  # Free enough space above this text
  if (!is.null(text_below)) {
    text[(find_line+1+n_lines_to_add):(n_lines_of_file+n_lines_to_add)] <- text_below
  }
  # Put the text to insert in the space now free
  text[(find_line+1):(find_line+n_lines_to_add)] <- insert

  # Write text in file
  cat(paste(text, collapse = "\n"), file = file)

}


# Check if vignettes in folder "vignettes" and in folder "docs/articles" differ
#
# Since the output of the vignette in the folder "vignette" is "html_vignette" and the output of the vignette in the folder "docs/articles" is "github_document", there will necessarily be changes. Therefore, the comparison is made on the files without the YAML.
#
# @param  x,y Names of the two vignettes to compare
#
# @return Boolean
# @keywords internal

vignettes_differ <- function(x, y) {

  if (!file.exists(x) || !file.exists(y)) {
    return(TRUE)
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


# Find image paths in Markdown files
#
# @param filename Name of the Markdown file from we which extract the image paths
#
# @keywords internal

get_img_paths <- function(filename) {

  file_content <- paste(readLines(filename, warn = FALSE), collapse = "\n")

  # when double quotes, i.e <img src="path">
  img_path_double_quotes <- unlist(
    regmatches(file_content,
               gregexpr('(?<=img src=\\").*?(?=\\")',
                        file_content, perl = TRUE)
              )
  )
  # when single quotes, i.e <img src='path'>
  img_path_single_quotes <- unlist(
    regmatches(file_content,
               gregexpr("(?<=img src=\\').*?(?=\\')",
                        file_content, perl = TRUE)
    )
  )

  img_path <- c(img_path_double_quotes, img_path_single_quotes)

  return(img_path)

}


# Replace old image paths by new ones
#
# @param filename Name of the Markdown file in which we replace the image paths
#
# @keywords internal
replace_img_paths <- function(filename) {

  file_content <- paste(readLines(filename, warn = FALSE), collapse = "\n")
  img_paths <- get_img_paths(filename)

  # Only keep the name (not the path that might be in filename)
  filename_alone <- trimws(basename(filename))
  # Create the path where the imgs will be stored
  path_to_store <- paste0(
    "_assets/img/",
    substr(filename_alone, 1, nchar(filename_alone)-3),
    "_img/"
  )
  # generate the new paths
  new_paths <- unlist(lapply(img_paths, function(x) {

    # Thanks stackoverflow: https://stackoverflow.com/questions/49499703/in-r-how-to-remove-everything-before-the-last-slash
    y <- trimws(basename(x))
    z <- gsub(y, "", x)
    paste0(path_to_store, y)
  }))

  # replace the old paths by the new ones
  for (i in seq_along(img_paths)) {
    file_content <- gsub(img_paths[i], new_paths[i], file_content)
  }

  cat(file_content, file = filename)

}


# Replace the img paths in README

replace_readme_img_paths <- function() {
  img_paths <- get_img_paths("docs/homepage.md")
  img_names <- trimws(basename(img_paths))

  if (!is.null(img_paths)) {
    fs::dir_create("docs/_assets/img/homepage_img")
    for (i in seq_along(img_paths)) {
      fs::file_copy(
        img_paths[i],
        paste0("docs/_assets/img/homepage_img/", img_names[i]),
        overwrite = T
      )
    }
    # replace the img paths but only in the README in the docs
    replace_img_paths("docs/homepage.md")
  }
}

# Unquote the title given in .Rmd file's YAML
#
# @param filename File concerned
#
# @keywords internal

unquote_title <- function(filename) {

  file_content <- readLines(filename, warn = FALSE)
  line_containing_title <- which(grepl("title:", file_content))
  title <- gsub(
    "title: ",
    "",
    file_content[line_containing_title]
  )

  if (is_quoted(title)) {
    title <- substr(title, 2, nchar(title))
    title <- substr(title, 1, nchar(title) - 1)
  }

  new_title <- paste0("title: ", title)

  file_content[line_containing_title] <- new_title

  cat(
    paste(file_content, collapse = "\n"),
    file = filename
  )

}

# Detect if a string is between quotation marks
#
# @param string String concerned
# @keywords internal

is_quoted <- function(string) {

  beg_string <- substr(string, 1, 1)
  end_string <- substr(string, nchar(string), nchar(string))

  if ((beg_string == "'" && end_string == "'") |
      (beg_string == '"' && end_string == '"')) {
    return(TRUE)
  } else {
    return(FALSE)
  }

}
