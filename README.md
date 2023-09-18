manMCMedMiss
================
Ivan Jacob Agaloos Pesigan
2023-09-18

<!-- README.md is generated from .setup/readme/README.Rmd. Please edit that file -->
<!-- badges: start -->

[![DOI](https://zenodo.org/badge/DOI/10.3758/s13428-023-02114-4.svg)](https://doi.org/10.3758/s13428-023-02114-4)
<!-- badges: end -->

## Description

Research compendium for the manuscript Pesigan, I. J. A., & Cheung, S.
F. (2023). Monte Carlo confidence intervals for the indirect effect with
missing data. *Behavior Research Methods*.
<https://doi.org/10.3758/s13428-023-02114-4>

## Acknowledgment

The simulation was performed in part at the High-Performance Computing
Cluster (HPCC) which is supported by the Information and Communication
Technology Office (ICTO) of the University of Macau. See
<https://icto.um.edu.mo/teaching-learning-research/high-performance-computing-cluster-hpcc/>
for more information on the University of Macau’s High-Performance
Computing Cluster (HPCC). We used the third-generation HPCC (Coral)
particularly the `serial-normal` and `serial-short` cluster partitions.
See `.sim/README.md` and the scripts in the `.sim` folder in the
[GitHub](https://github.com/jeksterslab/manMCMedMiss) repository for
more details on how the simulation was performed.

## Installation

You can install `manMCMedMiss` from
[GitHub](https://github.com/jeksterslab/manMCMedMiss) with:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("jeksterslab/manMCMedMiss")
```

See
[Containers](https://jeksterslab.github.io/manMCMedMiss/articles/containers.html)
for containerized versions of the package.

## Author-Accepted Manuscript

See
<https://github.com/jeksterslab/manMCMedMiss/blob/main/.setup/latex/manMCMedMiss-manuscript.Rtex>
for the latex file of the manuscript. See
<https://github.com/jeksterslab/manMCMedMiss/blob/latex/manMCMedMiss-manuscript.pdf>
for the compiled PDF.

## R Package

Monte Carlo confidence intervals for free and defined parameters in
models fitted in the structural equation modeling package `lavaan` can
be generated using the `semmcci` package. `semmcci` is available on the
Comprehensive R Archive Network (CRAN)
(<https://CRAN.R-project.org/package=semmcci>). Documentation and
examples can be found in the accompanying website
(<https://jeksterslab.github.io/semmcci>).

## More Information

See [GitHub
Pages](https://jeksterslab.github.io/manMCMedMiss/index.html) for
package documentation.

## Citation

To cite `semmcci` in publications, please cite Pesigan & Cheung (2023).

## References

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-Pesigan-Cheung-2023" class="csl-entry">

Pesigan, I. J. A., & Cheung, S. F. (2023). Monte Carlo confidence
intervals for the indirect effect with missing data. *Behavior Research
Methods*. <https://doi.org/10.3758/s13428-023-02114-4>

</div>

</div>
