data_process_results <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  results_file <- file.path(
    data_folder,
    "results.rda"
  )
  if (!file.exists(results_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    results <- readRDS(
      root$find_file(
        ".data-raw",
        "manMCMedMiss.Rds"
      )
    )
    n <- dim(results)[1]
    results <- results[
      n:1,
    ]
    rownames(results) <- 1:n
    Method <- rep(x = " ", times = n)
    for (i in 1:n) {
      if (
        results[i, "mechanism"] == "COMPLETE"
      ) {
        if (results[i, "method"] == "MC.ML") {
          Method[i] <- "MC.COMPLETE"
        }
        if (results[i, "method"] == "NBBC(ML)") {
          Method[i] <- "NBBC.COMPLETE"
        }
        if (results[i, "method"] == "NBPC(ML)") {
          Method[i] <- "NBPC.COMPLETE"
        }
        if (results[i, "method"] == "SIG.ML") {
          Method[i] <- "SIG.COMPLETE"
        }
      } else if (
        results[i, "mechanism"] %in% c("MAR", "MCAR")
      ) {
        if (results[i, "method"] == "MC.MI") {
          Method[i] <- "MC.MI"
        }
        if (results[i, "method"] == "MC.MI.ADJ") {
          Method[i] <- "MC.MI.ADJ"
        }
        if (results[i, "method"] == "MC.ML") {
          Method[i] <- "MC.FIML"
        }
        if (results[i, "method"] == "NBBC(ML)") {
          Method[i] <- "NBBC.FIML"
        }
        if (results[i, "method"] == "NBPC(ML)") {
          Method[i] <- "NBPC.FIML"
        }
        if (results[i, "method"] == "SIG.MI") {
          Method[i] <- "SIG.MI"
        }
        if (results[i, "method"] == "SIG.MI.ADJ") {
          Method[i] <- "SIG.MI.ADJ"
        }
        if (results[i, "method"] == "SIG.ML") {
          Method[i] <- "SIG.FIML"
        }
      }
    }
    results$method <- as.factor(Method)
    results$mechanism <- as.factor(as.character(results$mechanism))
    type1 <- rep(x = 0.0, times = n)
    for (i in 1:n) {
      if (results[i, "alphabeta"] > 0) {
        type1[i] <- NA
      } else {
        type1[i] <- 1 - results[i, "zero_hit"]
      }
    }
    power <- rep(x = 0.0, times = n)
    for (i in 1:n) {
      if (results[i, "alphabeta"] > 0) {
        power[i] <- 1 - results[i, "zero_hit"]
      } else {
        power[i] <- NA
      }
    }
    results$type1 <- type1
    results$power <- power
    results$miss <- 1 - results$theta_hit
    save(
      results,
      file = results_file,
      compress = "xz"
    )
  }
}
data_process_results()
rm(data_process_results)
