#' Change fields in index.html
#' @name change_in_index
#' @keywords internal
#' Function that automatically changes the github url in index.html
change_github_in_index <- function() {

  index_html <- paste(readLines("docs/index.html", warn = FALSE), collapse = "\n")
  mod_index <- gsub(
    "repo: ''",
    paste0("repo: '", get_github_url(),"'"),
    index_html
  )
  cat(mod_index, file = "docs/index.html")

}

#' @name change_in_index
#' @keywords internal
#' Function that automatically puts the package name as the name (title) of the documentation

change_pkgname_in_index <- function() {

  index_html <- paste(readLines("docs/index.html", warn = FALSE), collapse = "\n")
  mod_index <- gsub(
    "name: ''",
    paste0("name: '", get_pkgname(),"'"),
    index_html
  )
  cat(mod_index, file = "docs/index.html")

}


#' Obtain GitHub URL from the DESCRIPTION file
#'
#' @keywords internal
get_github_url <- function() {

  gh_url <- NULL

  if (file.exists("DESCRIPTION")) {

    # First-best: github repo is in "Issues" field
    # first best because there can be several urls in URL field, but it is unlikely
    # that there are several urls in Issues field
    gh_url <- github_url_in("BugReports")

    # Second-best: github repo is in URL field
    if (is.null(gh_url))
      gh_url <- github_url_in("URL")

  }

  return(gh_url)

}


#' Extract github URL from URL or BugReports fields in DESCRIPTION
#'
#' @param field URL or BugReports (or another field where the URL could appear)
#'
#' @keywords internal

github_url_in <- function(field = "URL") {

  description <- readLines("DESCRIPTION", warn = FALSE)
  line_with_url <- description[
    which(startsWith(description, paste0(field, ":")))
  ]

  check <- length(line_with_url)
  if (check > 0) {
    gh_urls <- gsub(paste0(field, ":"), "", line_with_url)
    gh_url <- unlist(strsplit(gh_urls, ","))
    gh_url <- gh_url[which(grepl("github.com/", gh_url))]
    gh_url <- gsub(" ", "", gh_url)

    if (grepl("/issues", gh_url))
      gh_url <- gsub("/issues", "", gh_url)

    return(gh_url)
  }

}


#' Get package name
#'
#' @keywords internal
get_pkgname <- function() {

  pkgname <- NULL

  if (file.exists("DESCRIPTION")) {
    description <- readLines("DESCRIPTION", warn = FALSE)
    line_with_name <- description[
      which(startsWith(description, "Package:"))
    ]
    pkgname <- gsub("Package: ", "", line_with_name)
  }

  return(pkgname)

}

