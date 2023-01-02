#!/bin/bash

#SBATCH --job-name              s03
#SBATCH --partition             serial-short
#SBATCH --nodes                 1
#SBATCH --time                  1-00:00:00
#SBATCH --mail-user             r.jeksterslab@gmail.com
#SBATCH --mail-type             ALL
#SBATCH --output                s03.archive.out
#SBATCH --error                 s03.archive.err
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

bash "$PROJECT_ARCHIVE/archive-parallel-03.sh"
