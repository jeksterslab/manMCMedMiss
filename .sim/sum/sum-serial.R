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
reps_start <- as.integer(args[1])
reps_end <- as.integer(args[2])
taskid <- as.integer(args[3])
repids <- reps_start:reps_end
for (i in seq_along(repids)) {
  tryCatch(
    {
      Sim(
        taskid = taskid,
        repid = repids[i],
        output_folder = output_folder,
        overwrite = overwrite,
        integrity = TRUE, # always true to check before summarizing
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
        repid = repids[i],
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
          repids[i],
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
          repids[i],
          "\n"
        )
      )
    }
  )
}
tryCatch(
  {
    Sum(
      taskid = taskid,
      reps = reps_end,
      output_folder = output_folder,
      params_taskid = params[which(params$taskid == taskid), ],
      nbmi = nbmi
    )
  },
  error = function(e) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "reps:",
        reps_end,
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
        "reps:",
        reps_end,
        "\n"
      )
    )
  }
)
warnings()
# ------------------------------------------------------------------------------
