# Reference


`add_css`: Add a CSS file to your documentation

<details>

 <summary> More </summary>

 **Usage:**

```
add_css(name = NULL, open = TRUE)
```
**Arguments:**

**`name`**: Name to give to the CSS file you want to create. If `NULL` , the file will be named `custom.css`

**`open`**: Open or not the file created. Default is TRUE.




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

 `add_reference`: Add a Markdown file with function references

<details>

 <summary> More </summary>

 **Usage:**

```
add_reference(include_internal = FALSE, section_above = NULL, type = "section")
```
**Arguments:**

**`include_internal`**: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). Default is FALSE. See Details.

**`section_above`**: Section that should be above the (sub)section you want to include. In other words, the (sub)section you want to include will be placed just below this section.

**`type`**: Section ("section") or subsection ("subsection")


**Details:**

This function is automatically called with `init_docsify()` by default. However, if you didn't want to create it at the beginning but you changed your mind after having run `init_docsify()` , you can run it on its own.
 
 If you don't want to include internal functions (i.e functions that are not exported by the package), include "@keywords internal" in the roxygen block of the function concerned, and use `include_internal = FALSE` .

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

add_reference()

```

</details>

---

 `add_sections`: Add the Code of Conduct, the License and the NEWS file as section or subsection

<details>

 <summary> More </summary>

 **Usage:**

```
add_code_of_conduct(section_above = NULL, type = "section")
add_news(section_above = NULL, type = "section")
add_license(section_above = NULL, type = "section")
```
**Arguments:**

**`section_above`**: Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.

**`type`**: "section" or "subsection"




</details>

---

 `add_to_sidebar`: Add a section to _sidebar.md

<details>

 <summary> More </summary>

 **Usage:**

```
add_to_sidebar(
  file,
  name,
  section_above = NULL,
  type = c("section", "subsection")
)
```
**Arguments:**

**`file`**: Name of the file to copy in "docs"

**`name`**: Name of the section or subsection to add

**`section_above`**: Name of the section under which the new section/subsection will be placed. If NULL (default), it will be placed under all the other sections.

**`type`**: "section" or "subsection"




</details>

---

 `add_vignettes`: Convert, move and insert vignettes

<details>

 <summary> More </summary>

 **Usage:**

```
add_vignettes(section_name = "Articles", section_above = "Home")
```
**Arguments:**

**`section_name`**: Name of the section containing the vignettes. Default is "Articles".

**`section_above`**: Section below which the section "Articles" (or the name given in `section_name` ) will be placed. By default, it will be placed just under "Home".




</details>

---

 `add`: Create a Markdown (or R Markdown) file to populate your documentation.

<details>

 <summary> More </summary>

 **Usage:**

```
add_md(name, open = TRUE)
add_rmd(name, open = TRUE)
```
**Arguments:**

**`name`**: Name of the .md (or .Rmd) file to create. If the file already exists, it will return an error.

**`open`**: Open or not the files created. Default is TRUE.




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

 `init_docsify`: Create the structure to use docsify in an R package

<details>

 <summary> More </summary>

 **Usage:**

```
init_docsify(
  open = TRUE,
  readme_as_homepage = TRUE,
  add_vignettes = TRUE,
  add_reference = TRUE,
  include_internal = FALSE,
  add_news = TRUE,
  add_license = TRUE,
  add_code_of_conduct = TRUE
)
```
**Arguments:**

**`open`**: Boolean indicating whether to open the HTML and Markdown files created. Default is TRUE.

**`readme_as_homepage`**: Put the README as homepage? Default is TRUE.

**`add_vignettes`**: Include vignettes as articles? Default is TRUE.

**`add_reference`**: Boolean indicating whether to add a Markdown file containing function references, i.e the list of functions (and their title and arguments) exported by the package. Default is TRUE.

**`include_internal`**: Boolean indicating if you want to include the documentation of internal (i.e non-exported functions). This requires `add_reference` to be TRUE. Default is FALSE See Details.

**`add_news`**: Put NEWS as Changelog? Default is TRUE.

**`add_license, add_code_of_conduct`**: Include License and Code of Conduct? Default is TRUE.


**Details:**

TO FILL.
 
 You can add a page containing the list of functions that your package provide, and their documentation. Internal functions (i.e functions that are not exported by the package) are included by default. If you don't want to include them, add "@keywords internal" in the roxygen block of the function concerned, and use `include_internal = FALSE` .

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

 `preview_docsify`: Preview the documentation in a webpage or in viewer

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

 `readme_as_homepage`: Put README as homepage

<details>

 <summary> More </summary>

 **Usage:**

```
readme_as_homepage()
```




</details>

---

 `update_docsify`: Update files in docs

<details>

 <summary> More </summary>

 **Usage:**

```
update_docsify(include_internal = FALSE)
```
**Arguments:**

**`include_internal`**: Boolean indicating if internal functions should be included in the "Reference" page.




</details>

---

