#!/usr/bin/env Rscript

# SIMULATION ARGUMENTS ---------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manMCMedMiss)
  )
)
source(
  file.path(
    "/data",
    "home",
    "yb47324",
    "share-lab",
    "sims",
    "src",
    SimProj(),
    ".sim",
    "sim-args.R"
  )
)
# ------------------------------------------------------------------------------

# RUN --------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
repid <- as.integer(args[1])
taskid <- as.integer(args[2])
tryCatch(
  {
    Sim(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      overwrite = overwrite,
      integrity = TRUE, # always true to check integrity before compressing
      params_taskid = params[which(params$taskid == taskid), ],
      alpha = alpha,
      m = m,
      R = R,
      B = B,
      mplus_bin = mplus_bin,
      nbmi = nbmi
    )
    Compress(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder
    )
  },
  error = function(e) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  },
  warning = function(w) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  }
)
warnings()
# ------------------------------------------------------------------------------
