#!/bin/bash

# pre TMP ----------------------------------------------------------------------
TODAY=$(date +"%Y-%m-%d-%H%M")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/data/home/yb47324/share-lab/tmp/$TODAY-p-XXXXXXXX")
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# {1} = repid
# {2} = taskid
parallel \
        --tmpdir "$PARALLEL_TMP_FOLDER" \
        'bash "$PROJECT_SIM_SH" {1} {2}; \
        echo sim 02 ip repid {1} taskid {2}' \
        ::: $(seq 2 20 5000) \
        ::: $(seq 1 236)
echo "sim-parallel-02-01.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
