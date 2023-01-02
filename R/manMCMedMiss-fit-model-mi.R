#' Fit the Simple Mediation Model using Multiple Imputation
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details
#' Let
#' \deqn{M = \textrm{Number of imputations}, \quad \textrm{and}}
#' \deqn{m = \left\{ 1, 2, \cdots, M \right\}.}
#' The vector of pooled coefficients/parameter estimates is given by
#' \deqn{
#'     \bar{\boldsymbol{\theta}}
#'     =
#'     M^{-1}
#'     \sum_{m = 1}^{M}
#'     \hat{\boldsymbol{\theta}}_{m} .
#' }
#' The covariance within imputations is given by
#' \deqn{
#'     \mathbf{V}_{\mathrm{within}}
#'     =
#'     M^{-1}
#'     \sum_{m = 1}^{M}
#'     \mathrm{Var}
#'     \left(
#'     \hat{\boldsymbol{\theta}}_{m}
#'     \right)
#' }
#' where \eqn{\mathrm{Var} \left( \hat{\boldsymbol{\theta}}_{m} \right)}
#' is the parameter covariance matrix for the \eqn{m^{\mathrm{th}}} imputation.
#' The covariance between imputations is given by
#' \deqn{
#'     \mathbf{V}_{\mathrm{between}}
#'     =
#'     \left(
#'     M - 1
#'     \right)^{-1}
#'     \sum_{m = 1}^{M}
#'     \left(
#'     \hat{\boldsymbol{\theta}}_{m}
#'     -
#'     \bar{\boldsymbol{\theta}}
#'     \right)
#'     \left(
#'     \hat{\boldsymbol{\theta}}_{m}
#'     -
#'     \bar{\boldsymbol{\theta}}
#'     \right)^{\prime} .
#' }
#' The total covariance matrix is given by
#' \deqn{
#'     \mathbf{V}_{\mathrm{total}}
#'     =
#'     \mathbf{V}_{\mathrm{within}}
#'     +
#'     \mathbf{V}_{\mathrm{between}}
#'     +
#'     M^{-1}
#'     \mathbf{V}_{\mathrm{between}} .
#' }
#' The adjusted total covariance matrix is given by
#' \deqn{
#'     \tilde{\mathbf{V}}_{\mathrm{total}}
#'     =
#'     \left(
#'     1
#'     +
#'     \mathrm{ARIV}
#'     \right)
#'     \mathbf{V}_{\mathrm{within}}
#' }
#' where
#' \deqn{
#'     \mathrm{ARIV}
#'     =
#'     k^{-1}
#'     \left[
#'     \left(
#'     1
#'     +
#'     M^{-1}
#'     \right)
#'     \mathrm{tr}
#'     \left(
#'     \mathbf{V}_{\mathrm{between}}
#'     \mathbf{V}_{\mathrm{within}}^{-1}
#'     \right)
#'     \right]
#' }
#' and \eqn{k} is the number of parameters.
#'
#' @return Returns a list with the following elements:
#' \describe{
#'   \item{coef}{
#'     Vector of pooled coefficients/parameter estimates
#'     \eqn{\bar{\boldsymbol{\theta}}}.
#'   }
#'   \item{vcov}{
#'     Total covariance matrix
#'     \eqn{\mathbf{V}_{\mathrm{total}}}.
#'   }
#'   \item{vcov_tilde}{
#'     Adjusted total covariance matrix
#'     \eqn{\tilde{\mathbf{V}}_{\mathrm{total}}}.
#'   }
#'   \item{vcov_between}{
#'     Covariance between imputations
#'     \eqn{\mathbf{V}_{\mathrm{between}}}.
#'   }
#'   \item{vcov_within}{
#'     Covariance within imputations
#'     \eqn{\mathbf{V}_{\mathrm{within}}}.
#'   }
#'   \item{ariv}{
#'     Average relative increase in variance
#'     \eqn{\mathrm{ARIV}}.
#'   }
#'   \item{m}{
#'     Number of imputations
#'     \eqn{M}.
#'   }
#'   \item{k}{
#'     Number of parameters
#'     \eqn{k}.
#'   }
#'   \item{nu1}{
#'     Numerator degrees of freedom
#'     \eqn{\nu_1} for \eqn{D_1}.
#'   }
#'   \item{nu2}{
#'     Denominator degrees of freedom
#'     \eqn{\nu_2} for \eqn{D_1}.
#'   }
#'   \item{d1}{
#'     \eqn{D_1} test statistic.
#'   }
#' }
#'
#' @references
#' Li, K. H., Raghunathan, T. E., & Rubin, D. B. (1991).
#' Large-sample significance levels from multiply imputed data
#' using moment-based statistics and an F reference distribution.
#' *Journal of the American Statistical Association*, 86 (416), 1065–1073.
#' \doi{10.1080/01621459.1991.10475152}
#'
#' Rubin, D. B. (1987).
#' *Multiple imputation for nonresponse in surveys*.
#' John Wiley & Sons, Inc.
#' \doi{10.1002/9780470316696}
#' @inheritParams Template
#' @export
#' @family Model Fitting Functions
#' @keywords manMCMedMiss fit mediation mi
FitModelMI <- function(data_mi,
                       mplus_bin) {
  m <- length(data_mi)
  fit <- lapply(
    X = data_mi,
    FUN = FitModelML,
    mplus_bin = mplus_bin
  )
  coefs <- lapply(
    X = fit,
    FUN = function(i) {
      i$coef
    }
  )
  coef <- (
    1 / m
  ) * Reduce(
    f = `+`,
    x = coefs
  )
  vcov_within <- (
    1 / m
  ) * Reduce(
    f = `+`,
    x = lapply(
      X = fit,
      FUN = function(i) {
        i$vcov
      }
    )
  )
  vcov_between <- (
    1 / (
      m - 1
    )
  ) * Reduce(
    f = `+`,
    x = lapply(
      X = coefs,
      FUN = function(i, coef) {
        tcrossprod(i - coef)
      },
      coef = coef
    )
  )
  # total parameter covariance matrix
  vcov <- vcov_within + vcov_between + (1 / m) * vcov_between
  # average relative increase in variance
  # Li, Raghunathan, and Rubin (1991)
  k <- length(coef)
  ariv <- (
    (
      1 + (
        1 / m
      )
    ) * sum(
      diag(
        vcov_between %*% solve(
          vcov_within
        )
      )
    )
  ) / k
  vcov_tilde <- (1 + ariv) * vcov_within
  # d1 denominator degrees of freedom
  kmmk <- k * m - k
  if (kmmk <= 4) {
    nu2 <- (
      kmmk * (
        1 + (
          1 / k
        )
      ) * (
        1 + (
          1 / ariv
        )
      )^2
    ) / 2
  } else {
    nu2 <- 4 + (
      kmmk - 4
    ) * (
      1 + (
        1 - (
          2 / kmmk
        )
      ) * (
        1 / ariv
      )
    )^2
  }
  d1 <- drop(
    (
      1 / k
    ) * crossprod(
      coef,
      chol2inv(
        chol(vcov_tilde)
      )
    ) %*% coef
  )
  return(
    list(
      coef = coef,
      vcov = vcov,
      vcov_tilde = vcov_tilde,
      vcov_between = vcov_between,
      vcov_within = vcov_within,
      ariv = ariv,
      m = m,
      k = k,
      nu1 = k,
      nu2 = nu2,
      d1 = d1
    )
  )
}
