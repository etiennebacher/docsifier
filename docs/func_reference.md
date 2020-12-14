# Reference


`add_css` : Add a CSS file to your documentation
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_css(name = NULL, open = TRUE)

 ``` 
 
 **Arguments:** 
* `name`: Name to give to the CSS file you want to create. If `NULL`, the file will be named `custom.css`
 
* `open`: Open or not the file created. Default is TRUE.
 


 **Examples:** 
 ```
# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

use_docsify()

# Create "custom.css"  in "/docs/_assets/css"

add_css()
 ```
 </details> 
 
--- 
 
`add_function_references` : Add a Markdown file with function references
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_function_references(include_internal = TRUE)

 ``` 
 
 **Arguments:** 
* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is TRUE. See Details.
 


 **Examples:** 
 ```
# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

use_docsify(add_reference = FALSE)

# Generate the "Reference" page in the documentation

add_function_references()
 ```
 </details> 
 
--- 
 
`add_md_rmd` : Create a Markdown (or R Markdown) file to populate your documentation.
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_md(name, open = TRUE)

add_rmd(name, open = TRUE)

 ``` 
 
 **Arguments:** 
* `name`: Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.
 
* `open`: Open or not the files created. Default is TRUE.
 


 **Examples:** 
 ```
# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

use_docsify()

# Create a new .md in "/docs"

add_md("test")

# Will output an error because "test.md" already exists

add_md("test")
 ```
 </details> 
 
--- 
 
`preview_docsify` : Preview the documentation in a webpage or in viewer
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
preview_docsify()

 ``` 
 
 **Examples:** 
 ```
# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

use_docsify()

# Run the preview

preview_docsify()
 ```
 </details> 
 
--- 
 
`use_docsify` : Create the structure to use docsify in an R package
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
use_docsify(open = TRUE, add_reference = FALSE, include_internal = FALSE)

 ``` 
 
 **Arguments:** 
* `open`: Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.
 
* `add_reference`: Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.
 
* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is TRUE. See Details.
 


 **Examples:** 
 ```
# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

use_docsify()
 ```
 </details> 
 
--- 
 
