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
        'Rscript "$PROJECT_COMPRESS_R" {1} {2}; \
        echo compress repid {1} taskid {2}' \
        ::: $(seq 4 20 5000) \
        ::: $(seq 1 472)
echo "compress-parallel-04.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
