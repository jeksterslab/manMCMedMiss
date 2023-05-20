data_process_elliot2007 <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  elliot2007 <- read.table(
    root$find_file(
      ".data-raw",
      "elliot2007.txt"
    ),
    col.name = c("x", "m1", "m2", "y1", "y2")
  )
  m <- elliot2007$m2 - elliot2007$m1
  y <- elliot2007$y2 - elliot2007$y1
  x <- elliot2007$x
  elliot2007 <- cbind(
    x = x,
    m = m,
    y = y
  )
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  save(
    elliot2007,
    file = file.path(
      data_folder,
      "elliot2007.rda"
    ),
    compress = "xz"
  )
}
data_process_elliot2007()
rm(data_process_elliot2007)
