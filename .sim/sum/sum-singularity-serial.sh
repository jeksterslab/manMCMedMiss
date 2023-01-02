#!/bin/bash

# NOTE: Give serial-short and serial-normal a 24-hour head-start before running this.
# This is a way to monitor and summarize results every 200 replications.

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
for index in $(seq 1 25); do
        # summary
        for end in $(seq 200 200 5000); do
                ((start=end-200+1))
                for taskid in $(seq 1 472); do
                        singularity exec \
                                --bind /data/home/yb47324/share-lab \
                                "$PROJECT_SIF" \
                                Rscript "$PROJECT_SUM_SERIAL_R" "$start" "$end" "$taskid"
                        echo summary reps "$start" to "$end" taskid "$taskid"
                done
        done
        # bind
        singularity exec \
                --bind /data/home/yb47324/share-lab \
                "$PROJECT_SIF" \
                Rscript "$PROJECT_SUM_BIND_R"
        echo summary finished "$end"
done
