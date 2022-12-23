#!/bin/bash

# THIS SHOULD BE RUN WITH sim-singularity-*.sh

# pre TMP ----------------------------------------------------------------------
TODAY=$(date +"%Y-%m-%d-%H%M")
TMP_FOLDER=$(mktemp -d -q "/data/home/yb47324/share-lab/tmp/$TODAY-s-XXXXXXXX" || exit 1)
trap 'rm -rf -- "$TMP_FOLDER"' EXIT
export TMPDIR="$TMP_FOLDER"
export TMP="$TMP_FOLDER"
export TEMP="$TMP_FOLDER"
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# $1 = repid
# $2 = taskid
Rscript "$PROJECT_SIM_R" "$1" "$2"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
