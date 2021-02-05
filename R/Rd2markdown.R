### This code was copied from https://github.com/quantsch/Rd2md
### Complete source: https://github.com/quantsch/Rd2md/blob/master/R/Rd2markdown.R
### Copied on 2021-02-05
### I slightly changed it

Rd2markdown <- function(rdfile, include_internal = FALSE) {

  # VALIDATION
 if (is.character(rdfile)) if ((length(rdfile) !=  1))
    stop(message_error("Please provide rdfile as single character
                       value (file path with extension)."))

  type <- ifelse(inherits(rdfile, "Rd"), "bin", "src")


  # Parse rd file
  if (type == "src") {
    rd <- tools::parse_Rd(paste0("man/", rdfile))
  } else {
    if (inherits(paste0("man/", rdfile), "list"))  {
      rdfile <- paste0("man/", rdfile)[[1]]
    }
    rd <- paste0("man/", rdfile)
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
