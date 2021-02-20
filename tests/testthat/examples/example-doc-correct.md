`e_bar`: Bar and Line chart

<details>

 <summary> More </summary>

 **Usage:**

```
e_bar(
  e,
  serie,
  bind,
  name = NULL,
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  coord_system = "cartesian2d",
  ...
)
e_bar_(
  e,
  serie,
  bind = NULL,
  name = NULL,
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  coord_system = "cartesian2d",
  ...
)
```
**Arguments:**

**`e`**: An `echarts4r` object as returned by [`e_charts`](#echarts) or a proxy as returned by [`echarts4rProxy`](#echarts4rproxy) .

**`serie`**: Column name of serie to plot.

**`bind`**: Binding between datasets, namely for use of [`e_brush`](#ebrush) .

**`name`**: name of the serie.

**`legend`**: Whether to add serie to legend.

**`x_index, y_index`**: Indexes of x and y axis.

**`coord_system`**: Coordinate system to plot against.

**`...`**: Any other option to pass, check See Also section.




**Examples:**
```
library(dplyr)

mtcars %>%
mutate(
model = row.names(.),
total = mpg + qsec
) %>%
arrange(desc(total)) %>%
e_charts(model) %>%
e_bar(mpg, stack = "grp") %>%
e_bar(qsec, stack = "grp")

```

</details>

---

