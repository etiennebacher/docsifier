test_that("get_in_text obtains the good information", {
  x <- testthat::test_path("examples", "example-doc.Rd")
  rd_file <- paste(readLines(x), collapse = "")

  expect_equal(
    get_in_text("name", rd_file),
    "e_bar"
  )
  expect_equal(
    get_in_text("usage", rd_file),
    "e_bar(  e,  serie,  bind,  name = NULL,  legend = TRUE,  y_index = 0,  x_index = 0,  coord_system = \"cartesian2d\",  ...)e_bar_(  e,  serie,  bind = NULL,  name = NULL,  legend = TRUE,  y_index = 0,  x_index = 0,  coord_system = \"cartesian2d\",  ...)"
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

  rd_file <- paste(readLines(x), collapse = "")
  rd_file2 <- paste(readLines(x2), collapse = "")
  rd_file3 <- paste(readLines(x3), collapse = "")
  rd_file4 <- paste(readLines(x4), collapse = "")


  expect_equal(
    get_in_text("examples", rd_file),
    "library(dplyr)mtcars \\%>\\%  mutate(    model = row.names(.),    total = mpg + qsec  ) \\%>\\%  arrange(desc(total)) \\%>\\%  e_charts(model) \\%>\\%  e_bar(mpg, stack = \"grp\") \\%>\\%  e_bar(qsec, stack = \"grp\")"
  )

  expect_equal(
    get_in_text("examples", rd_file2),
    "ui <- fluidPage(  actionBttn(    inputId = \"bttn1\"  ))server <- function(input, output) {  output$res_bttn1 <- renderPrint(input$bttn1)  output$res_bttn2 <- renderPrint({input$bttn2})}shinyApp(ui = ui, server = server)"
  )

  expect_equal(
    get_in_text("examples", rd_file3),
    "library(ggplot2)plot1 <- ggplot(mtcars, aes(hp, drat)) +  geom_point()tinyslider(plot_to_card(plot1))"
  )

  expect_equal(
    get_in_text("examples", rd_file4),
    "library(ggplot2)plot1 <- ggplot(mtcars, aes(hp, drat)) +  geom_point()tinyslider(plot_to_card(plot1))"
  )

})
