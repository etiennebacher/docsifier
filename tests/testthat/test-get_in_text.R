test_that("get_in_text obtains the good information", {
  x <- testthat::test_path("examples", "example-doc.Rd")
  rd_file <- readChar(x, file.info(x)$size)

  expect_equal(
    get_in_text("name", rd_file),
    "e_bar"
  )
  expect_equal(
    get_in_text("usage", rd_file),
    "\ne_bar(\n  e,\n  serie,\n  bind,\n  name = NULL,\n  legend = TRUE,\n  y_index = 0,\n  x_index = 0,\n  coord_system = \"cartesian2d\",\n  ...\n)\n\ne_bar_(\n  e,\n  serie,\n  bind = NULL,\n  name = NULL,\n  legend = TRUE,\n  y_index = 0,\n  x_index = 0,\n  coord_system = \"cartesian2d\",\n  ...\n)\n"
  )
  expect_equal(
    get_in_text("argument", rd_file),
    c("e", "serie", "bind", "name", "legend",
      "x_index, y_index", "coord_system", "...")
  )
  expect_equal(
    get_in_text("argument_description", rd_file),
    c("Column name of serie to plot.", "name of the serie.",
      "Whether to add serie to legend.", "Indexes of x and y axis.",
      "Coordinate system to plot against.",
      "Any other option to pass, check See Also section.",
      "Additional arguments")
  )

})


test_that("get_in_text can obtain the examples, whatever they're wrapped in", {

  # not wrapped in anything else than \examples{}
  x <- test_path("examples", "example-doc.Rd")
  # wrapped in if (interactive)
  x2 <- test_path("examples", "example-doc2.Rd")
  # wrapped in \dontrun{}
  x3 <- test_path("examples", "example-doc3.Rd")
  # wrapped in \donttest{}
  x4 <- test_path("examples", "example-doc4.Rd")

  rd_file <- readChar(x, file.info(x)$size)
  rd_file2 <- readChar(x2, file.info(x2)$size)
  rd_file3 <- readChar(x3, file.info(x3)$size)
  rd_file4 <- readChar(x4, file.info(x4)$size)


  expect_equal(
    get_in_text("examples", rd_file),
    "\nlibrary(dplyr)\n\nmtcars \\%>\\%\n  mutate(\n    model = row.names(.),\n    total = mpg + qsec\n  ) \\%>\\%\n  arrange(desc(total)) \\%>\\%\n  e_charts(model) \\%>\\%\n  e_bar(mpg, stack = \"grp\") \\%>\\%\n  e_bar(qsec, stack = \"grp\")"
  )

  expect_equal(
    get_in_text("examples", rd_file2),
    "\nui <- fluidPage(\n  actionBttn(\n    inputId = \"bttn1\"\n  )\n)\nserver <- function(input, output) {\n  output$res_bttn1 <- renderPrint(input$bttn1)\n  output$res_bttn2 <- renderPrint({input$bttn2})\n}\nshinyApp(ui = ui, server = server)"
  )

  expect_equal(
    get_in_text("examples", rd_file3),
    "\nlibrary(ggplot2)\n\nplot1 <- ggplot(mtcars, aes(hp, drat)) +\n  geom_point()\n\ntinyslider(plot_to_card(plot1))"
  )

  expect_equal(
    get_in_text("examples", rd_file4),
    "\nlibrary(ggplot2)\n\nplot1 <- ggplot(mtcars, aes(hp, drat)) +\n  geom_point()\n\ntinyslider(plot_to_card(plot1))"
  )

})
