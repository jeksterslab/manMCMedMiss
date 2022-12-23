#!/bin/bash

#SBATCH --job-name              check-serial-normal
#SBATCH --partition             serial-normal
#SBATCH --nodes                 1
#SBATCH --time                  00:00:05
#SBATCH --exclusive
#SBATCH --mem                   0
#SBATCH --mail-user             r.jeksterslab@gmail.com
#SBATCH --mail-type             ALL
#SBATCH --output                check-serial-normal.hpc.out
#SBATCH --error                 check-serial-normal.hpc.err

echo "serial-normal"
echo "cpus:"
echo "$SLURM_CPUS_ON_NODE"
echo "mem:"
echo "$SLURM_MEM_PER_NODE"
echo "cores detected by parallel:"
singularity exec \
        "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/manmcmedmiss.sif" \
        parallel --number-of-cores
echo "lscpu"
lscpu
echo "free -g -h -t"
free -g -h -t
echo "printenv"
printenv
