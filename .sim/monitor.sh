#!/bin/bash

cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
watch 'squeue -u yb47324; squeue -u sfcheung ; for i in *.out ; do tail -1 "$i" ; done ; grep "check" *.out ; cat *.err'
