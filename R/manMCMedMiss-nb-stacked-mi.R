#' Nonparametric Bootstrap Confidence Intervals for the Indirect Effect
#' using Multiple Imputation
#' (NB using Stacked MI)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Nonparametric bootstrap percentile confidence intervals.
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation mi
NBStackedMI <- function(data_mi,
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
  data_mi_stacked <- do.call(
    what = "rbind",
    args = data_mi
  )
  thetahatstar <- .Vec(
    sapply(
      X = 1:B,
      FUN = function(i, data, n, m) {
        FitModelIndirect(
          data_complete = data[
            sample.int(
              n = n * m,
              size = n,
              replace = TRUE
            ),
          ]
        )
      },
      data = data_mi_stacked,
      n = nrow(data_mi[[1]]),
      m = length(data_mi)
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
