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
        echo sim 15 sf repid {1} taskid {2}' \
        ::: $(seq 15 20 5000) \
        ::: $(seq 237 472)
echo "sim-parallel-15-02.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
