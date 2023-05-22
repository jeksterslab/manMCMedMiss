#' Nonparametric Bootstrap Confidence Intervals for the Indirect Effect
#' using Multiple Imputation
#' (NB nested within MI or MI(NB))
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Nonparametric bootstrap confidence intervals.
#'   `bc` corresponds to bias-corrected and `pc` corresponds to percentile
#'  confidence intervals.
#'
#' @references
#' Wu, Wei., & Jia, F. (2012).
#' A new procedure to test mediation with missing data
#' through nonparametric bootstrapping and multiple imputation.
#' *Multivariate Behavioral Research*, *48*(5), 663–691.
#' \doi{10.1080/00273171.2013.816235}
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation mi
MINB <- function(data_mi,
                 B = 5000L,
                 alpha = c(0.05, 0.01, 0.001)) {
  probs <- .ProbsofAlpha(alpha = alpha)
  z1 <- stats::qnorm(p = probs)
  thetahat <- mean(
    .Vec(
      sapply(
        X = data_mi,
        FUN = FitModelIndirect
      )
    )
  )
  thetahatstar <- .Vec(
    sapply(
      X = data_mi,
      FUN = function(data,
                     n,
                     B) {
        sapply(
          X = 1:B,
          FUN = function(i,
                         data,
                         n) {
            FitModelIndirect(
              data_complete = data[
                sample.int(
                  n = n,
                  size = n,
                  replace = TRUE
                ),
              ]
            )
          },
          data = data,
          n = n
        )
      },
      n = nrow(data_mi[[1]]),
      B = B
    )
  )
  z0 <- stats::qnorm(
    sum(
      thetahatstar < thetahat
    ) / (
      B * length(data_mi)
    )
  )
  pc <- stats::quantile(
    thetahatstar,
    probs = probs
  )
  bc <- stats::quantile(
    thetahatstar,
    probs = stats::pnorm(
      q = 2 * z0 + z1
    )
  )
  names(bc) <- names(pc)
  return(
    rbind(
      bc = bc,
      pc = pc
    )
  )
}
