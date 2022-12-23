#' Simulation Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @format A dataframe with 24,544 rows and 13 columns:
#'
#' \describe{
#'   \item{zero_hit}{
#'     The proportion of replications
#'     where the confidence intervals contained zero.
#'   }
#'   \item{theta_hit}{
#'     The proportion of replications
#'     where the confidence intervals
#'     contained the population \eqn{\alpha \beta}.
#'   }
#'   \item{replications}{
#'     Simulation replications.
#'   }
#'   \item{taskid}{
#'     Simulation Task ID.
#'   }
#'   \item{tauprime}{
#'     \eqn{\tau^{\prime}}, that is,
#'     the path from \eqn{X} to \eqn{Y}, adjusting for \eqn{M}.
#'   }
#'   \item{beta}{
#'     \eqn{\beta}, that is, the path from \eqn{M} to \eqn{Y}.
#'   }
#'   \item{alpha}{
#'     \eqn{\alpha}, that is, the path from \eqn{X} to \eqn{M}.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{sigmasqepsilonm}{
#'     Error variance \eqn{\sigma^{2}_{\varepsilon_{M}}}.
#'   }
#'   \item{sigmasqepsilony}{
#'     Error variance \eqn{\sigma^{2}_{\varepsilon_{Y}}}.
#'   }
#'   \item{alphabeta}{
#'     \eqn{\alpha \beta}, that is,
#'     the indirect effect of \eqn{X} on \eqn{Y} via \eqn{M}.
#'   }
#'   \item{mechanism}{
#'     Missing data mechanism.
#'    `"COMPLETE"` for complete data,
#'    `"MCAR"` for missing completely at random, and
#'    `"MAR"` for missing at random.
#'   }
#'   \item{proportion}{
#'     Proportion of missing data (.0, .1, .2, .3).
#'   }
#'   \item{method}{
#'     Method used.
#'   }
#'   \item{type1}{
#'     Type I error rate.
#'   }
#'   \item{power}{
#'     Statistical power.
#'   }
#'   \item{miss}{
#'     Miss rate.
#'   }
#' }
#'
#' The methods are as follows:
#' \describe{
#'     \item{MC.COMPLETE}{
#'       for Monte Carlo method
#'       with maximum likelihood estimates for complete data.
#'     }
#'     \item{MC.FIML}{
#'       for Monte Carlo method
#'       with full information maximum likelihood estimates.
#'     }
#'     \item{MC.MI}{
#'       for Monte Carlo method with multiple imputation estimates.
#'     }
#'     \item{MC.MI.ADJ}{
#'       for Monte Carlo method with adjusted multiple imputation estimates.
#'     }
#'     \item{NBBC.COMPLETE}{
#'       for bias-corrected nonparametric bootstrap
#'       with maximum likelihood estimates for complete data.
#'     }
#'     \item{NBBC.FIML}{
#'       for full maximum likelihood
#'       nested within bias-corrected nonparametric bootstrap.
#'     }
#'     \item{NBPC.COMPLETE}{
#'       for percentile nonparametric bootstrap
#'       with full maximum likelihood estimates for complete.
#'     }
#'     \item{NBPC.FIML}{
#'       for full maximum likelihood
#'       nested within percentile nonparametric bootstrap.
#'     }
#'     \item{SIG.COMPLETE}{
#'       for joint-significant test for complete data.
#'     }
#'     \item{SIG.FIML}{
#'       for the joint-significant test with full maximum likelihood estimates.
#'     }
#'     \item{SIG.MI}{
#'       for joint-significant test with multiple imputation estimates.
#'     }
#'     \item{SIG.MI.ADJ}{
#'       for the joint-significant test
#'       with adjusted multiple imputation estimates.
#'     }
#' }
#'
#' @keywords data results
"results"

#     \item{MI(NBBC)}{
#       for bias-corrected nonparametric bootstrap
#       nested within multiple imputation.
#     }
#     \item{MI(NBPC)}{
#       for percentile nonparametric bootstrap
#       nested within multiple imputation.
#     }
