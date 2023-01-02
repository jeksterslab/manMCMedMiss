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
taskid <- as.integer(args[1])
tmp <- tempdir()
project_taskid <- paste0(
  SimProj(),
  "-",
  sprintf(
    "%05d",
    taskid
  )
)
output_folder_taskid <- file.path(
  output_folder,
  project_taskid
)
archive <- paste0(
  file.path(
    tmp,
    paste0(
      "archive",
      "-",
      sprintf(
        "%05d",
        taskid
      ),
      ".sh"
    )
  )
)
files <- paste0(
  file.path(
    tmp,
    paste0(
      "files",
      "-",
      sprintf(
        "%05d",
        taskid
      )
    )
  )
)
shebang <- paste0(
  "#!/bin/bash",
  "\n"
)
parallel <- paste0(
  "export XZ_DEFAULTS=\"-T 0\"",
  "\n"
)
cd <- paste(
  "cd",
  output_folder_taskid,
  "\n"
)
find <- paste(
  "find",
  ".",
  '-maxdepth 1 -type f -name "*.Rds" >',
  files,
  "\n"
)
tar <- paste(
  "tar",
  "vcf",
  paste0(
    output_folder_taskid,
    ".tar"
  ),
  "-T",
  files,
  "\n"
)
xz <- paste(
  "xz",
  "-9v",
  "-T0",
  paste0(
    output_folder_taskid,
    ".tar"
  ),
  "\n"
)
clean <- paste(
  "rm",
  files,
  "\n",
  "rm",
  archive,
  "\n"
)
fileConn <- file(archive)
writeLines(
  paste0(
    shebang,
    parallel,
    cd,
    find,
    tar,
    xz,
    clean
  ),
  fileConn
)
close(fileConn)
# clean
tar_xz <- paste0(
  output_folder_taskid,
  ".tar",
  ".xz"
)
if (file.exists(tar_xz)) {
  unlink(tar_xz)
}
# archive
system(
  paste(
    "bash",
    archive
  )
)
# check integrity
system(
  paste0(
    "xz -t",
    " ",
    output_folder_taskid,
    ".tar",
    ".xz"
  )
)

# OUTPUT OF "archive-00001.sh" SHOULD BE

# !/bin/bash
# export XZ_DEFAULTS="-T 0"
# cd /data/home/yb47324/share-lab/sims/dat/manMCMedMiss/manMCMedMiss-00001
# find . -maxdepth 1 -type f -name "*.Rds" > $TMPDIR/detritus/files-00001
# tar vcf /data/home/yb47324/share-lab/sims/dat/manMCMedMiss/manMCMedMiss-00001.tar -T $TMPDIR/files-00001
# xz -9v -T0 /data/home/yb47324/share-lab/sims/dat/manMCMedMiss/manMCMedMiss-00001.tar
# rm $TMPDIR/files-00001
# rm $TMPDIR/archive-00001.sh
