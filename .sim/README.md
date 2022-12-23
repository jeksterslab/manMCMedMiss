# Directory Tree Structure

## Simulation Source Files/Project Folder

Run the following to prepare the project folder.

```bash
mkdir -p "/data/home/yb47324/share-lab/sims/src"
git clone git@github.com:jeksterslab/manMCMedMiss.git
mv manMCMedMiss "/data/home/yb47324/share-lab/sims/src"
chmod -R 777 "/data/home/yb47324/share-lab/sims/src/manMCMedMiss"
```

## Simulation Output Folder

Run the following to prepare the output folder.

```bash
mkdir -p "/data/home/yb47324/share-lab/sims/dat"
chmod 777 "/data/home/yb47324/share-lab/sims/dat"
```

## Simulation Temporary Folder

Run the following to prepare the temporary folder.

```bash
mkdir -p "/data/home/yb47324/share-lab/tmp"
chmod 777 "/data/home/yb47324/share-lab/tmp"
```

## Simulation Scripts

The simulation scripts are in the following folder.

```bash
"/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
```

> **NOTE**: Build or request for `manmcmedmiss.sif` and place it in `"/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"`.

[comment]: <> (The manmcmedmiss.sif used is in https://osf.io/xh8nb/)

In order to save the output files in the `"/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"` directory, make sure that `$PWD` is equal to `"/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"`.

# Sequence of Scripts to Run in the HPC Cluster

## Simulation

Run the following until all replications are finished. Rerun as many times as necessary.

```bash
# serial-short - 1 day max
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-01.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-02.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-03.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-04.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-05.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-06.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-07.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-08.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-09.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-10.sh"
```

```bash
# serial-normal - 6 days max
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-11.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-12.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-13.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-14.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-15.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-16.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-17.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-18.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-19.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sim-singularity-parallel-20.sh"
```

To reduce the time the scripts use checking completed replications, especially when many replications queued under a job are finished, edit `sim-parallel-*.sh` as necessary after the job terminates when the maximum allowed time (1 day for `serial-short` and 6 days for `serial-normal`) is reached. For example, when the last `repid` in the last run of `sim-singularity-parallel-01.sh` is `41`, change `$(seq 1 20 5000)` to `$(seq 41 20 5000)` in `sim-parallel-01.sh` before requeueing `sim-singularity-parallel-01.sh`.

### Step-Wise Summary and Monitoring

Run the following in the head node to summarize the results every 200 replications. Make sure to give `sim-singularity-parallel-*.sh`a 24-hour head start before running `sum-singularity-serial.sh`.

```bash
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
bash "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-serial.sh"
```

Run the following to monitor running scripts in the SLURM queue and to print the last line in the `*.out` files.
Summarizing and monitoring the results step-wise is a good way of determining if everything is in order. Check for unexpected and inconsistent results and investigate their root cause to determine if there are bugs and errors in the code.

## Summary

Run the following scripts to summarize the results.

```bash
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-01.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-02.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-03.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-04.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-05.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-06.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-07.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-08.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-09.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-10.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-11.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-12.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-13.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-14.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-15.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-16.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-17.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-18.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-19.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/sum-singularity-parallel-20.sh"
```

## Bind All Results

Run the following script to bind the results for all 472 tasks into a single file. The output will be saved as `"/data/home/yb47324/share-lab/sims/src/manMCMedMiss/data-raw/manMCMedMiss.Rds"`.

```bash
bash sum-bind-singularity-serial.sh
```

## Compress Output

No compression is used in the simulation to prioritize speed over disk space. Compression can be applied in preparation for archiving.

```bash
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-01.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-02.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-03.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-04.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-05.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-06.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-07.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-08.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-09.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-10.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-11.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-12.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-13.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-14.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-15.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-16.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-17.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-18.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-19.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/compress-singularity-parallel-20.sh"
```

## Archive Output

The following scripts will archive the results. Results for a particular `taskid` will be archived into a single `tar.xz` file. For example, results for `taskid = 1` will be archived as `"/data/home/yb47324/share-lab/sims/dat/manMCMedMiss/manMCMedMiss-0001.tar.xz"`

```bash
cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-01.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-02.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-03.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-04.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-05.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-06.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-07.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-08.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-09.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-10.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-11.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-12.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-13.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-14.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-15.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-16.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-17.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-18.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-19.sh"
sbatch "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim/archive-singularity-parallel-20.sh"
```

## Transfer Output to Local Drive

```bash
rsync -avzh --progress --remove-source-files --dry-run USER@IPADDRESS:SERVER_DIR LOCAL_DIR
```
