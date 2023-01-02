#!/bin/bash

# hpc settings -----------------------------------------------------------------
source /etc/profile
source /etc/profile.d/modules.sh
module purge
module add singularity/3.8.0
ulimit -s unlimited
# ------------------------------------------------------------------------------

# env --------------------------------------------------------------------------
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
source set.sh manMCMedMiss
# ------------------------------------------------------------------------------

# MAIN -------------------------------------------------------------------------
for repid in $(seq 1 5000); do
        for taskid in $(seq 1 472); do
                singularity exec \
                        --bind /data/home/yb47324/share-lab \
                        "$PROJECT_SIF" \
                        bash "$PROJECT_SIM_SH" "$repid" "$taskid"
                echo serial repid "$repid" taskid "$taskid"
        done
done
# ------------------------------------------------------------------------------
