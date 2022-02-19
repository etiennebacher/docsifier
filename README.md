**This repo is archived. See [altdoc](github.com/etiennebacher/altdoc) instead**

# docsifier

<!-- badges: start -->
[![](https://codecov.io/gh/etiennebacher/docsifier/branch/master/graphs/badge.svg)](https://codecov.io/github/etiennebacher/docsifier)
[![](https://github.com/etiennebacher/docsifier/workflows/R-CMD-check/badge.svg)](https://github.com/etiennebacher/docsifier/actions)
<!-- badges: end -->

The goal of `{docsifier}` is to provide helper functions to create the documentation of an R package or project with [docsify.js](https://docsify.js.org/#/).

## Installation 

You can install the development version with:

``` r
# install.packages("devtools")
devtools::install_github("etiennebacher/docsifier")
```


## Basic demo

This is a small demo that shows the main steps for creating the documentation. For more details about e.g customization, or deployment, check out the [website](https://docsifier.etiennebacher.com).


First, let’s create a package called `dummy` using RStudio buttons (New Project > New Directory > R Package). This package has the following structure:
```
.
├── DESCRIPTION
├── NAMESPACE
├── R
│   └── hello.R
├── dummy.Rproj
└── man
    └── hello.Rd
```

You can do your development workflow as usual. In fact, you can add the documentation whenever you want. Let's create it now.

```r
> library(docsifier)
> init_docsify()

── Import docsify.js files ───────────────────────────────────────────────────────
✓ Folder "docs" has been created.
✓ Setting active project to 'path/to/dummy'
✓ Adding '^docs$' to '.Rbuildignore'
✓ Files "index.html", "homepage.md" and "_sidebar.md" have been created.

── Create content ────────────────────────────────────────────────────────────────
✓ 'Reference' section has been added.
ℹ File NEWS.md doesn't exist.
ℹ Files LICENSE.md and LICENCE.md don't exist.
ℹ File CODE_OF_CONDUCT.md doesn't exist.
ℹ No vignettes to transform.
```
This code has created the folder `docs` and added basic docsify.js files in it (note that this will not work if you already have a folder "docs").
```
.
├── DESCRIPTION
├── NAMESPACE
├── R
│   └── hello.R
├── docs
│   ├── _sidebar.md
│   ├── docsify_files
│   │   ├── docsify.min.js
│   │   └── vue.min.css
│   ├── homepage.md
│   ├── index.html
│   └── reference.md
├── dummy.Rproj
└── man
    └── hello.Rd
```

Finally, you can already run `preview_docsify()` to see what the documentation looks like. 

More details and features on the [website](https://docsifier.etiennebacher.com/#/).


## Code of Conduct

Please note that the docsifier project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
