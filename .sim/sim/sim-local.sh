# This has to be run in the manMCMedMiss project folder
parallel \
        Rscript .sim/sim/sim.R {1} {2} \
        ::: $(seq 1 2) \
        ::: $(seq 1 472)
