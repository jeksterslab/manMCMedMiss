#!/bin/bash

# env --------------------------------------------------------------------------
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
source set.sh manMCMedMiss
# ------------------------------------------------------------------------------

reps=5000
singularity exec \
        --bind /data/home/yb47324/share-lab \
        "$PROJECT_SIF" \
        bash "$PROJECT_SUM/sum-parallel.sh" "$reps"
