# This has to be run in the manMCMedMiss project folder
parallel \
        Rscript .sim/sum/sum.R {1} {2} \
        ::: 2 \
        ::: $(seq 1 472)
