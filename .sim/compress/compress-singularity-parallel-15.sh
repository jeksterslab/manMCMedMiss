#!/bin/bash

#SBATCH --job-name              n15
#SBATCH --partition             serial-normal
#SBATCH --nodes                 1
#SBATCH --time                  6-00:00:00
#SBATCH --mail-user             r.jeksterslab@gmail.com
#SBATCH --mail-type             ALL
#SBATCH --output                n15.compress.out
#SBATCH --error                 n15.compress.err
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
        bash "$PROJECT_COMPRESS/compress-parallel-15.sh"
