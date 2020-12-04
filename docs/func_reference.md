# Reference


`add_css` : Add a CSS file to your documentation
 <details>
 <summary> More </summary> 
 
 ``` 
add_css(name = NULL)

 ``` 
 
 **Arguments:** 

* `name`: Name to give to the CSS file you want to create. If `NULL`, the file will be named `custom.css`
 

 </details> 
 
--- 
 
`add_function_references` : Add a Markdown file with function references
 <details>
 <summary> More </summary> 
 
 ``` 
add_function_references(include_internal = TRUE)

 ``` 
 
 **Arguments:** 

* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is TRUE. See Details.
 

 </details> 
 
--- 
 
`add_md_rmd` : Create a Markdown (or R Markdown) file to populate your documentation.
 <details>
 <summary> More </summary> 
 
 ``` 
add_md(name)

add_rmd(name)

 ``` 
 
 **Arguments:** 

* `name`: Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.
 

 </details> 
 
--- 
 
`preview_docsify` : Preview the documentation in a webpage or in viewer
 <details>
 <summary> More </summary> 
 
 ``` 
preview_docsify()

 ``` 
 
 **Arguments:** 


 </details> 
 
--- 
 
`use_docsify` : Create the structure to use docsify in an R package
 <details>
 <summary> More </summary> 
 
 ``` 
use_docsify(open = TRUE, add_reference = TRUE, include_internal = TRUE)

 ``` 
 
 **Arguments:** 

* `open`: Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.
 
* `add_reference`: Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.
 
* `include_internal`: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is TRUE. See Details.
 

 </details> 
 
--- 
 
