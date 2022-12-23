#' Monte Carlo Confidence Intervals for the Indirect Effect
#' using Normal Theory Maximum Likelihood
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Monte Carlo confidence intervals.
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation ml
MCML <- function(fit_ml,
                 R = 20000L,
                 alpha = c(0.05, 0.01, 0.001)) {
  thetahatstar <- MASS::mvrnorm(
    n = R,
    mu = fit_ml$coef,
    Sigma = fit_ml$vcov
  )
  return(
    stats::quantile(
      thetahatstar[, "m~x"] * thetahatstar[, "y~m"],
      probs = .ProbsofAlpha(alpha = alpha)
    )
  )
}
