# Build, populate, and preview your documentation

`{docsifier}` provides three types of functions to build the structure of the documentation, add the content, and preview it.


## Build the structure

The first function is `init_docsify()`. This function works in two steps.

First of all, if the folder `/docs` doesn't already exist, it will create it. If the folder already exists, it will not overwrite it.

Secondly, when the folder `/docs` is created, it will add Markdown (`.md`) and HTML (`.html`) files inside it. More precisely, these are the files that will be generated:

* `index.html`, which is where the call to `docsify.js` is made. It is also the place where you can add or remove options. We will see this later. **This file is absolutely essential**, which is why `init_docsify()` returns an error if it already exists. 
 
* `_sidebar.md`, `homepage.md`, and `howto.md` provide a minimal documentation so that you can already see what the documentation will look like. Their content is explained in the next part.

* if you are in a package environment with a `/man` folder, and if you choose `add_reference = TRUE`, `reference.md` will also be created. This file generates a section called "Reference" that contains some details on the functions you created in your package.


With these basic files, you can already run `preview_docsify()` to have a preview of your documentation in RStudio Viewer or in a web browser.



## Add contents to your documentation

### Structure of contents

Before explaining how to add contents, let's detail the structure of the `.md` files. `_sidebar.md` is where you can define the main sections of your documentation. As you can see in the default file, this is done by linking `.md` files to a particular section. This only works if you have put `loadSidebar: true` in `index.html` (which is the default).

`homepage.md` and `howto.md` are some files that are just here to show what the documentation looks like before doing any changes.

### Add contents

You can add either `.Rmd` or `.md` files with `add_rmd()` and `add_md()`. These two functions only take a character vector as argument. For instance, `add_md("deploy")` will create `/docs/deploy.md`.

You may also want to add a file that contains details for the functions. As said above, this can be done by specifying `add_reference = TRUE` in `init_docsify()`. But if you didn't specify this argument, you can still create this file after `init_docsify()` by calling `add_reference()`. This is also useful when you want to update the function details.


## Preview the documentation

As said earlier, you can preview the documentation in RStudio Viewer or a web browser (by clicking on the button in RStudio Viewer) with `preview_docsify()`.













