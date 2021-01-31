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

library(docsifier)

# Create a test folder and a test package for the example

test_folder <- tempdir()
setwd(test_folder)
devtools::create("dummy")
setwd("dummy")

# Generate the minimal documentation for docsify.js

init_docsify(add_reference = FALSE)

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
 
`add_to_sidebar` : Add a section to _sidebar.md
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
add_to_sidebar(section_name, subsection_name = NULL, subsection_md_file = NULL)

 ``` 
 
 **Arguments:** 
* `section_name`: Name of the section created with this file. If NULL, the name of the file is used.
 
* `filename`: Name of the file to add, must be a Markdown (.md) file
 


 </details> 
 
--- 
 
`as_snake_case` : Transform string in snake case
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
as_snake_case(x)

 ``` 
 
 **Arguments:** 
* `x`: String to transform
 


 </details> 
 
--- 
 
`build_function_reference` : Gather the important info in .Rd files
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
build_function_reference(include_internal = TRUE)

 ``` 
 
 </details> 
 
--- 
 
`folder_is_empty` : Detect if the folder is empty
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
folder_is_empty(x)

 ``` 
 
 **Arguments:** 
* `x`: Name of the folder
 


 </details> 
 
--- 
 
`get_in_text` : Obtain words between curly braces in .Rd files
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
get_in_text(item, text)

 ``` 
 
 **Arguments:** 
* `item`: Text from which to extract.
 
* `text`: NA
 


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
  readme_as_homepage = TRUE,
  add_news = TRUE
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
 
`is_it_a_package` : Detect if we are in a package environment or not
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
is_it_a_package()

 ``` 
 
 </details> 
 
--- 
 
`link_md_to_section` : Link a .md file to a section in _sidebar.md
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
link_md_to_section(md_file, section_name)

 ``` 
 
 **Arguments:** 
* `md_file`: Name of the .md file to link
 
* `section_name`: Name of the section to which link the .md file
 


 </details> 
 
--- 
 
`message_validate` : Wrappers for cli messages
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
message_validate(x)

 ``` 
 
 **Arguments:** 
* `x`: Message (character vector)
 


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
 
`transform_vignettes` : Convert .Rmd files to give .md files
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
transform_vignettes()

 ``` 
 
 </details> 
 
--- 
 
`update_file` : Update a file in folder "docs"
 <details>
 <summary> More </summary> 
 
 **Usage:** 
 ``` 
update_file(filename, name_in_doc = NULL)

 ``` 
 
 **Arguments:** 
* `filename`: Name of the file which is up-to-date.
 
* `name_in_doc`: Name of the file to be updated in "docs".
 


 </details> 
 
--- 
 
