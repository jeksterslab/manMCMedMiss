#!/bin/bash

# env --------------------------------------------------------------------------
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
source set.sh manMCMedMiss
# ------------------------------------------------------------------------------

bash "$PROJECT_ARCHIVE/archive-parallel.sh"
