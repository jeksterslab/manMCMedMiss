#!/bin/bash

# env --------------------------------------------------------------------------
source "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/set.sh" manMCMedMiss
# ------------------------------------------------------------------------------

singularity exec \
        --bind /data/home/yb47324/share-lab \
        "$PROJECT_SIF" \
        Rscript "$PROJECT_SUM_BIND_R"
