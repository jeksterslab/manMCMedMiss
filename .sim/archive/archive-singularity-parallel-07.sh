#!/bin/bash

#SBATCH --job-name              s07
#SBATCH --partition             serial-short
#SBATCH --nodes                 1
#SBATCH --time                  1-00:00:00
#SBATCH --mail-user             r.jeksterslab@gmail.com
#SBATCH --mail-type             ALL
#SBATCH --output                s07.archive.out
#SBATCH --error                 s07.archive.err
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

bash "$PROJECT_ARCHIVE/archive-parallel-07.sh"
