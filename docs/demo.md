# Demo 

Let’s see the steps to create your documentation with `{docsifier}`. First, let’s create a dummy package:

``` r
devtools::create("dummy")
```

This has the following structure:

    .
    ├── DESCRIPTION
    ├── NAMESPACE
    ├── R
    │   └── hello.R
    ├── dummy.Rproj
    └── man
        └── hello.Rd

You can do your development workflow as usual. In fact, you can add the
documentation whenever you want. For now, we just create the
documentation.

```r
library(docsifier)
use_docsify()

✓ Folder "docs" has been created.
✓ File "index.html" has been created.
✓ Files "homepage.md", "_sidebar.md", and "howto.md" have been created.
```

```
.
├── DESCRIPTION
├── NAMESPACE
├── R
│   └── hello.R
├── docs
│   ├── _sidebar.md
│   ├── homepage.md
│   ├── howto.md
│   └── index.html
├── dummy.Rproj
└── man
    └── hello.Rd
```

We can see that the folder "docs" and the template files were created. If you already had a folder "docs", the files would have been created inside. You can already run `preview_docsify()` to see what the documentation looks like. 

The structure of the documentation is made in `_sidebar.md` and the options detailed in the part "Customize" are in `index.html`. You can now add `.md` or `.Rmd` files in "docs" with `add_md()` and `add_rmd()`. If you want to customize the style of the documentation, you can add a CSS file with `add_css()` or check the themes available [online](https://docsify.js.org/#/themes).

When you have finished your documentation, you can deploy it with several tools. This procedure is detailed in the "Deploy" part. 


