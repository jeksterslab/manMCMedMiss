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
SumBind(
  tasks = tasks,
  output_folder = output_folder,
  data_raw_folder = file.path(
    "/data",
    "home",
    "yb47324",
    "share-lab",
    "sims",
    "src",
    SimProj(),
    ".data-raw"
  ),
  params = params
)
warnings()
# ------------------------------------------------------------------------------
