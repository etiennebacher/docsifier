#' Add a Markdown file with function references
#'
#' @param include_internal Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is FALSE. See Details.
#'
#' @param section_above Section that should be above the (sub)section you want to include. In other words, the (sub)section you want to include will be placed just below this section.
#' @param type Section ("section") or subsection ("subsection")
#'
#' @details This function is automatically called with `init_docsify()` by default. However, if you didn't want to create it at the beginning but you changed your mind after having run `init_docsify()`, you can run it on its own.
#'
#' If you don't want to include internal functions (i.e functions that are not exported by the package), include "@@keywords internal" in the roxygen block of the function concerned, and use `include_internal = FALSE`.
#'
#' @return Creates a Markdown file called "reference.md" in the folder "docs", and edit "_sidebar.md" to add a "Reference" section.
#' @export
#'
#' @examples
#' \dontrun{
#'
#' library(docsifier)
#'
#' # Create a test folder and a test package for the example
#'
#' test_folder <- tempdir()
#' setwd(test_folder)
#' devtools::create("dummy")
#' setwd("dummy")
#'
#' # Generate the minimal documentation for docsify.js
#'
#' init_docsify(add_reference = FALSE)
#'
#' # Generate the "Reference" page in the documentation
#'
#' add_reference()
#' }

add_reference <- function(
  include_internal = FALSE,
  section_above = NULL,
  type = "section"
){

  if (!file.exists("man")) {
    message_info('There is no folder "man", section "Reference" was not created.')
  } else {

    list_man <- list.files("man/", pattern = ".Rd")
    list_man_md <- unlist(lapply(list_man, function(x) {
      Rd2markdown(rdfile = paste0("man/", x), include_internal = include_internal)
    }))

    if (!fs::file_exists("docs/reference.md")) {
      fs::file_copy(
        system.file("templates/reference-template.md",
                    package = "docsifier"),
        "docs/reference.md"
      )
    } else {

      fs::file_copy(
        system.file(
          "templates/reference-template.md",
          package = "docsifier"
        ),
        "docs/reference.md",
        overwrite = TRUE
      )

    }

    # append the markdown text we made into the file
    cat(list_man_md, file = "docs/reference.md", append = TRUE)

    sidebar_md <- paste(readLines("docs/_sidebar.md", warn = FALSE),
                        collapse = "\n")
    if (!grepl("reference.md", sidebar_md)) {
      add_to_sidebar(
        file = "docs/reference.md",
        name = "Reference",
        section_above = section_above,
        type = type
      )
      message_validate("'Reference' section has been added.")
    } else {
      message_validate("'Reference' section has been updated.")
    }

  }

}



### This code was copied from https://github.com/quantsch/Rd2md
### Complete source: https://github.com/quantsch/Rd2md/blob/master/R/Rd2markdown.R
### Copied on 2021-02-05
### I slightly changed it

# Convert a .Rd file into a Markdown file
#
# @param rdfile Name of the .Rd file to convert
# @param include_internal If FALSE, internal functions (those with keyword "internal") return NULL.
#
# @keywords internal

Rd2markdown <- function(rdfile, include_internal = FALSE) {

  # VALIDATION
  if (is.character(rdfile)) if ((length(rdfile) !=  1))
    stop(message_error("Please provide rdfile as single character
                       value (file path with extension)."))

  type <- ifelse(inherits(rdfile, "Rd"), "bin", "src")


  # Parse rd file
  if (type == "src") {
    rd <- tools::parse_Rd(rdfile)
  } else {
    if (inherits(rdfile, "list"))  {
      rdfile <- rdfile[[1]]
    }
    rd <- rdfile
    class(rd) <- "Rd"
  }
  # takes as input an "Rd" object
  results <- Rd2md::parseRd(rd)

  if (include_internal == FALSE) {
    if (!is.null(results$keyword)) {
      if ("internal" %in% results$keyword) {
        return(NULL)
      }
    }
  }

  arguments_names <- names(results$arguments)
  arguments_formatted <- unlist(lapply(
    seq_along(results$arguments), function(x) {
      paste0("**`", names(results$arguments[x]), "`**: ",
             results$arguments[x], "\n")
    }))

  results_formatted <- paste0(

    "`", results$name, "`: ", results$title, "\n\n",
    "<details>\n\n <summary> More </summary>\n\n **Usage:**\n\n",
    "```\n",
    results$usage, "\n",
    "```\n",
    if (!is.null(arguments_names)) {
      paste0(
        "**Arguments:**\n\n",
        paste(arguments_formatted, collapse = "\n")
      )
    },
    "\n\n",
    if (!is.null(results$details)) {
      paste0(
        "**Details:**\n\n",
        results$details
      )
    },
    "\n\n",
    if (!is.null(results$examples)) {
      paste0(
        "**Examples:**\n",
        "```\n",
        results$examples,
        "\n\n",
        "```\n\n"
      )
    },
    "</details>\n\n---\n\n"
  )

  return(results_formatted)

}

