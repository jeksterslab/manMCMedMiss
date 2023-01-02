#!/bin/bash

#SBATCH --job-name              s05
#SBATCH --partition             serial-short
#SBATCH --nodes                 1
#SBATCH --time                  1-00:00:00
#SBATCH --mail-user             r.jeksterslab@gmail.com
#SBATCH --mail-type             ALL
#SBATCH --output                s05.compress.out
#SBATCH --error                 s05.compress.err
#SBATCH --mem                   0
#SBATCH --exclusive

# hpc settings -----------------------------------------------------------------
source /etc/profile
source /etc/profile.d/modules.sh
module purge
module load singularity/3.8.0
ulimit -s unlimited
# ------------------------------------------------------------------------------

# env --------------------------------------------------------------------------
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
source set.sh manMCMedMiss
# ------------------------------------------------------------------------------

singularity exec \
        --bind /data/home/yb47324/share-lab \
        "$PROJECT_SIF" \
        bash "$PROJECT_COMPRESS/compress-parallel-05.sh"
