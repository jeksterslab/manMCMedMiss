#!/bin/bash

# THE PROJECT NAME SHOULD BE SUPPLIED AS AN ARGUMENT ($1)

# common environment variables
# project
export PROJECT=$1
# src
export PROJECT_HOME="/data/home/yb47324/share-lab/sims/src/$PROJECT" 
# dat
export PROJECT_DATA_HOME="/data/home/yb47324/share-lab/sims/dat/$PROJECT"
# scripts
export PROJECT_SCRIPTS="$PROJECT_HOME/.sim" 
# sim
export PROJECT_SIM="$PROJECT_SCRIPTS/sim"
export PROJECT_SIM_R="$PROJECT_SIM/sim.R"
export PROJECT_SIM_SH="$PROJECT_SIM/sim.sh"
export PROJECT_SIM_CHECK_R="$PROJECT_SIM/sim-check.R"
# sum
export PROJECT_SUM="$PROJECT_SCRIPTS/sum"
export PROJECT_SUM_R="$PROJECT_SUM/sum.R"
export PROJECT_SUM_SERIAL_R="$PROJECT_SUM/sum-serial.R"
# sum-bind
export PROJECT_SUM_BIND_R="$PROJECT_SUM/sum-bind.R"
# compress
export PROJECT_COMPRESS="$PROJECT_SCRIPTS/compress"
export PROJECT_COMPRESS_R="$PROJECT_COMPRESS/compress.R"
# archive
export PROJECT_ARCHIVE="$PROJECT_SCRIPTS/archive"
export PROJECT_ARCHIVE_R="$PROJECT_ARCHIVE/archive.R"
# sif
export PROJECT_LOWERCASE=`echo "$PROJECT" | awk '{print tolower($0)}'`
export PROJECT_SIF="$PROJECT_SCRIPTS/$PROJECT_LOWERCASE.sif"

# OpenBLAS' multithreading might "conflict"
# with the main program's multithreading
# and recommends setting OPENBLAS_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
