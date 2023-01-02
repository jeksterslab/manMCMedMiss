#!/bin/bash

cd "/data/home/yb47324/share-lab/sims/src/manMCMedMiss/.sim"
nohup bash sum-singularity-serial.sh >| serial.sum.out 2>&1 &
