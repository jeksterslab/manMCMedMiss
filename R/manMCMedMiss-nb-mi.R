#' Nonparametric Bootstrap Confidence Intervals for the Indirect Effect
#' using Multiple Imputation
#' (MI nested within NB or NB(MI))
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Nonparametric bootstrap percentile confidence intervals.
#'
#' @references
#' Zhang, Z., & Wang, L. (2012).
#' Methods for mediation analysis with missing data.
#' *Psychometrika*, *78*(1), 154–184.
#' \doi{10.1007/s11336-012-9301-5}
#'
#' Zhang, Z., Wang, L., & Tong, X. (2015).
#' Mediation analysis with missing data
#' through multiple imputation and bootstrap.
#' *Quantitative psychology research* (pp. 341–355).
#' Springer International Publishing.
#' \doi{10.1007/978-3-319-19977-1_24}
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation mi
NBMI <- function(data_missing,
                 data_mi,
                 B = 5000L,
                 m = 100L,
                 alpha = c(0.05, 0.01, 0.001),
                 mplus_bin) {
  # only available for illustration
  # this approach is too computationally intensive
  # to include in the simulation study
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
  fit <- function(data_missing,
                  m,
                  mplus_bin) {
    return(
      mean(
        sapply(
          X = ImputeData(
            data_missing = data_missing,
            m = m,
            mplus_bin = mplus_bin
          ),
          FUN = FitModelIndirect
        )
      )
    )
  }
  thetahatstar <- .Vec(
    sapply(
      X = 1:B,
      FUN = function(b,
                     data_missing,
                     n,
                     m,
                     mplus_bin) {
        fit(
          data_missing = data_missing[
            sample.int(
              n = n,
              size = n,
              replace = TRUE
            ),
          ],
          m = m,
          mplus_bin = mplus_bin
        )
      },
      data_missing = data_missing,
      n = dim(data_missing)[1],
      m = m,
      mplus_bin = mplus_bin
    )
  )
  z0 <- stats::qnorm(
    sum(
      thetahatstar < thetahat
    ) / B
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
