#' Monte Carlo Confidence Intervals for the Indirect Effect
#' using Multiple Imputation
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a list with the following elements:
#' \describe{
#'   \item{vcov}{
#'     Monte Carlo confidence intervals based on the total covariance matrix.
#'   }
#'   \item{vcov_tilde}{
#'     Monte Carlo confidence intervals
#'     based on the adjusted total covariance matrix.
#'   }
#' }
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation mi
MCMI <- function(fit_mi,
                 R = 20000L,
                 alpha = c(0.05, 0.01, 0.001)) {
  thetahatstar <- MASS::mvrnorm(
    n = R,
    mu = fit_mi$coef,
    Sigma = fit_mi$vcov
  )
  probs <- .ProbsofAlpha(alpha = alpha)
  vcov <- stats::quantile(
    thetahatstar[, "m~x"] * thetahatstar[, "y~m"],
    probs = probs
  )
  thetahatstar <- MASS::mvrnorm(
    n = R,
    mu = fit_mi$coef,
    Sigma = fit_mi$vcov_tilde
  )
  vcov_tilde <- stats::quantile(
    thetahatstar[, "m~x"] * thetahatstar[, "y~m"],
    probs = probs
  )
  return(
    rbind(
      vcov,
      vcov_tilde
    )
  )
}
