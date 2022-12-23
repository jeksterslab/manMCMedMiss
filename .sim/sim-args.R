# SIMULATION ARGUMENTS ---------------------------------------------------------
nbmi <- FALSE
local <- FALSE
tasks <- dim(manMCMedMiss::params)[1]
reps <- 5000L
overwrite <- FALSE
alpha <- c(0.05, 0.01, 0.001)
R <- 20000L
B <- 5000L
m <- 100L
if (local) {
  mplus_bin <- file.path(
    Sys.getenv("HOME"),
    ".local",
    "bin",
    "mpdemo"
  )
} else {
  mplus_bin <- "mpdemo"
}
# ------------------------------------------------------------------------------
output_root <- file.path(
  "/data",
  "home",
  "yb47324",
  "share-lab",
  "sims",
  "dat"
)
project <- manMCMedMiss::SimProj()
output_folder <- manMCMedMiss:::.SimPath(
  root = output_root,
  project = project
)
# ------------------------------------------------------------------------------
