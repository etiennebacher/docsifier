library(fs)
library(usethis)
library(withr)


### Taken from {usethis} (file "R/project.R")

proj <- new.env(parent = emptyenv())

proj_get_ <- function() proj$cur

proj_set_ <- function(path) {
  old <- proj$cur
  proj$cur <- path
  invisible(old)
}



### Taken from {usethis} (file "tests/testthat/helper.R")

create_local_package <- function(
  dir = file_temp(pattern = "testpkg"),
  env = parent.frame(),
  rstudio = TRUE
) {
  create_local_thing(dir, env, rstudio, "package")
}


create_local_project <- function(
  dir = file_temp(pattern = "testproj"),
  env = parent.frame(),
  rstudio = FALSE
) {
  create_local_thing(dir, env, rstudio, "project")
}


create_local_thing <- function(
  dir = file_temp(pattern = pattern),
  env = parent.frame(),
  rstudio = FALSE,
  thing = c("package", "project")
) {

  thing <- match.arg(thing)
  if (fs::dir_exists(dir)) {
    ui_stop("Target {ui_code('dir')} {ui_path(dir)} already exists.")
  }

  old_project <- proj_get_() # this could be `NULL`, i.e. no active project
  old_wd <- getwd() # not necessarily same as `old_project`

  defer(
    {
      ui_done("Deleting temporary project: {ui_path(dir)}")
      fs::dir_delete(dir)
    },
    envir = env
  )
  ui_silence(
    switch(
      thing,
      package = create_package(dir, rstudio = rstudio, open = FALSE, check_name = FALSE),
      project = create_project(dir, rstudio = rstudio, open = FALSE)
    )
  )

  defer(proj_set(old_project, force = TRUE), envir = env)
  proj_set(dir)

  defer(
    {
      ui_done("Restoring original working directory: {ui_path(old_wd)}")
      setwd(old_wd)
    },
    envir = env
  )
  setwd(proj_get())

  invisible(proj_get())
}


expect_proj_file <- function(...) expect_true(file_exists(proj_path(...)))

