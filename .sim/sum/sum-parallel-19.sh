#!/bin/bash

# pre TMP ----------------------------------------------------------------------
TODAY=$(date +"%Y-%m-%d-%H%M")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/data/home/yb47324/share-lab/tmp/$TODAY-p-XXXXXXXX" || exit 1)
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
# ------------------------------------------------------------------------------

# MAIN -------------------------------------------------------------------------
# {1} = reps
# {2} = taskid
parallel \
        --tmpdir "$PARALLEL_TMP_FOLDER" \
        'Rscript "$PROJECT_SUM_R" {1} {2}; \
        echo summary taskid {2}' \
        ::: "$1" \
        ::: $(seq 433 456)
echo "sum-parallel-19.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
