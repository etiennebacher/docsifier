
<!-- README.md is generated from README.Rmd. Please edit that file -->

# docsifier

\[WORK IN PROGRESS - USE WITH CAUTION\]

<!-- badges: start -->

<!-- badges: end -->

  - [Installation](#installation)
  - [Purpose of `docsifier`](#purpose)
  - [How to use](#howto)
  - [Experimental](#experimental)
  - [Code of Conduct](#CoC)

The goal of docsifier is to generate the structure to use
[docsify.js](https://docsify.js.org/#/) for the documentation of an R
package.

## Installation

You can install the development version with:

``` r
# install.packages("devtools")
devtools::install_github("etiennebacher/docsifier")
```

## Purpose of `docsifier`

Docsify uses two things:

  - an index written in HTML that contains several options for the page,
    such as the presence of a navbar, a coverpage, the color of the
    background, etc.

  - one or several Markdown files that populate the page. These files
    contain the documentation that you want to include in your page.

`docsifier` can’t create the documentation for you, this is still your
work. However, it provides helpers so that the creation of the
documentation with Docsify is easier.

## How to use

**Note that `docsifier` only works for R packages.** `docsifier`
provides three functions: `use_docsifier()`, `add_rmd()` and `add_md()`.

The first one creates the bare structure that Docsify needs: a folder
“docs” (if there isn’t already one), an HTML file called `index.html`,
and a Markdown file called `homepage.md`.

For example, this is the folder structure of this package (at its early
stage) before `use_docsifier()`…

    #> .
    #> ├── R
    #> ├── inst
    #> │   └── templates
    #> └── man

… and after its use:

``` r
use_docsify(open = FALSE)
#> ✓ Folder "docs" has been created.
#> ✓ Files "index.html" and "homepage.md" have been created.
```

    #> .
    #> ├── R
    #> ├── docs
    #> ├── inst
    #> │   └── templates
    #> └── man

    #> docs
    #> ├── homepage.md
    #> └── index.html

The two other functions are `add_rmd()` `add_md()`. These functions are
very simple: they just create respectively an `.Rmd` and an `.md` file
in “docs” to save some time.

## Experimental

A set of functions to install and run docsify:

  - `dep_available()` to check if Node.js and npm are installed (should
    work)

  - `install_docsify()` to install docsify on user’s computer (doesn’t
    work at all)

  - `preview_docsify()` to preview the documentation in a webpage (works
    but can’t be stopped)

## Code of Conduct

Please note that the docsifier project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
