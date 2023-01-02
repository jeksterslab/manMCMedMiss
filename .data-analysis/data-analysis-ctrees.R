data_process_ctrees <- function() {
  root <- rprojroot::is_rstudio_project
  # load functions
  source(
    root$find_file(
      ".setup",
      "load",
      "load.R"
    )
  )
  Load(root)
  # load data
  x <- list.files(
    path = root$find_file(
      "data"
    ),
    pattern = "\\.rda$",
    full.names = TRUE,
    all.files = TRUE,
    recursive = TRUE
  )
  x <- c(
    x,
    list.files(
      path = root$find_file(
        ".data-dependencies"
      ),
      pattern = "\\.rda$",
      full.names = TRUE,
      all.files = TRUE,
      recursive = TRUE
    )
  )
  if (length(x) > 0) {
    for (i in seq_along(x)) {
      load(x[i])
    }
    rm(i)
  }
  results_no_adj <- results
  results_no_adj <- results_no_adj[
    which(
      !(
        results_no_adj$method %in% c("MC.MI.ADJ", "SIG.MI.ADJ")
      )
    ),
  ]
  results_no_adj$method <- factor(results_no_adj$method)
  results <- results_no_adj
  type1 <- Tree(
    results,
    type = "type1"
  )
  power <- Tree(
    results,
    type = "power"
  )
  miss <- Tree(
    results,
    type = "miss"
  )
  print.SplittingNode <- function(x, ...) {
    cat(
      sprintf(
        "%d, %f, %d, %f, %d, %f\n",
        x$nodeID,
        x$prediction,
        x$left$nodeID,
        x$left$prediction,
        x$right$nodeID,
        x$right$prediction
      )
    )
    print(x$left)
    print(x$right)
  }
  capture.output(
    print(type1),
    file = root$find_file(
      ".data-analysis",
      "type1.txt"
    )
  )
  capture.output(
    print(type1@tree),
    file = root$find_file(
      ".data-analysis",
      "type1-percentage.txt"
    )
  )
  capture.output(
    print(power),
    file = root$find_file(
      ".data-analysis",
      "power.txt"
    )
  )
  capture.output(
    print(power@tree),
    file = root$find_file(
      ".data-analysis",
      "power-percentage.txt"
    )
  )
  capture.output(
    print(miss),
    file = root$find_file(
      ".data-analysis",
      "miss.txt"
    )
  )
  capture.output(
    print(miss@tree),
    file = root$find_file(
      ".data-analysis",
      "miss-percentage.txt"
    )
  )
}
data_process_ctrees()
rm(data_process_ctrees)
