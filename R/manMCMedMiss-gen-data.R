#' Generate Data
#'
#' Let the simple mediation model be defined by
#' the equations
#' \deqn{Y = \delta_{Y} + \tau^{\prime} X + \beta M + \varepsilon_{Y},}
#' and
#' \deqn{M = \delta_{M} + \alpha X + \varepsilon_{M}.}
#' The function generates data from the multivariate normal distribution
#' using the model-implied mean vector and covariance matrix
#' of the simple mediation model.
#' See `MASS::mvrnorm()` for more details.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @references
#' MacKinnon, D. P. (2008).
#' *Introduction to statistical mediation analysis*.
#' Lawrence Erlbaum Associates.
#'
#' @return Returns a matrix.
#'
#' @inheritParams Template
#' @export
#' @family Data Generation Functions
#' @keywords manMCMedMiss gendata mediation normal
GenData <- function(n = 100L,
                    tauprime = 0,
                    beta = 0.5,
                    alpha = 0.5,
                    mu = 0,
                    sigmasq = 1) {
  sigmaxx <- sigmamm <- sigmayy <- sigmasq
  sigmaxm <- alpha * sigmaxx
  sigmaxy <- beta * alpha * sigmaxx + tauprime * sigmaxx
  sigmamy <- (
    beta * alpha^2 * sigmaxx +
      tauprime * alpha * sigmaxx +
      beta * (sigmamm - alpha^2 * sigmaxx)
  )
  return(
    MASS::mvrnorm(
      n = n,
      mu = c(x = mu, m = mu, y = mu),
      Sigma = matrix(
        data = c(
          sigmaxx, sigmaxm, sigmaxy,
          sigmaxm, sigmamm, sigmamy,
          sigmaxy, sigmamy, sigmayy
        ),
        ncol = 3
      )
    )
  )
}
