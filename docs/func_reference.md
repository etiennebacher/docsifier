# Reference


`add` : Create a Markdown (or R Markdown) file to populate your documentation.
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

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify()

# Create a new .md in "/docs"

add_md("test")

# Will output an error because "test.md" already exists

add_md("test")
 ```
 </details> 
 
--- 
 
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

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify()

# Create "custom.css"  in "/docs/_assets/css"

add_css()
 ```
 </details> 
 
--- 
 
`add_functions_reference` : Add a Markdown file with function references
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_functions_reference(
  include_internal = FALSE,
  section_above = NULL,
  type = "section"
)

 ``` 
 
 **Arguments:** 
* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is TRUE. See Details.
 


 **Examples:** 
 ```

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify(add_reference = FALSE)

# Generate the "Reference" page in the documentation

add_functions_reference()
 ```
 </details> 
 
--- 
 
`add_sections` : Add the Code of Conduct, the License and the NEWS file as section or subsection
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_code_of_conduct(section_above = NULL, type = "section")

add_news(section_above = NULL, type = "section")

add_license(section_above = NULL, type = "section")

 ``` 
 
 **Arguments:** 
* `section_above`: Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.
 
* `type`: "section" or "subsection"
 


 </details> 
 
--- 
 
`init_docsify` : Create the structure to use docsify in an R package
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
init_docsify(
  open = TRUE,
  add_reference = TRUE,
  include_internal = FALSE,
  add_news = TRUE,
  add_license = TRUE,
  add_code_of_conduct = TRUE
)

 ``` 
 
 **Arguments:** 
* `open`: Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.
 
* `add_reference`: Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.
 
* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is TRUE. See Details.
 


 **Examples:** 
 ```

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify()
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

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify()

# Run the preview

preview_docsify()
 ```
 </details> 
 
--- 
 
