#!/bin/bash

# THIS SHOULD BE RUN WITH archive-singularity-*.sh

# pre TMP ----------------------------------------------------------------------
TODAY=$(date +"%Y-%m-%d-%H%M")
TMP_FOLDER=$(mktemp -d -q "/data/home/yb47324/share-lab/tmp/$TODAY-s-XXXXXXXX" || exit 1)
trap 'rm -rf -- "$TMP_FOLDER"' EXIT
export TMPDIR="$TMP_FOLDER"
export TMP="$TMP_FOLDER"
export TEMP="$TMP_FOLDER"
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# xz uses multiple cores
for taskid in $(seq 1 472); do
        singularity exec \
                --bind /data/home/yb47324/share-lab \
                "$PROJECT_SIF" \
                Rscript "$PROJECT_ARCHIVE_R" "$taskid"
        echo archive taskid "$taskid"
done
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
