#' Combine Parameter Estimates Vector and Sampling Variance-Covariance Matrix
#' Estimated from Multiple Imputations
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param param_vec List of vectors of paramater estimates.
#' @param var_mat List of matrices of sampling variances and covariances.
#'
#' @return Returns a list with the following elements:
#' \describe{
#'   \item{m}{
#'     Number of imputations
#'     \eqn{M}.
#'   }
#'   \item{k}{
#'     Number of parameters
#'     \eqn{k}.
#'   }
#'   \item{estimates}{
#'     Vector of pooled coefficients/parameter estimates
#'     \eqn{\bar{\boldsymbol{\theta}}}.
#'   }
#'   \item{within}{
#'     Covariance within imputations
#'     \eqn{\mathbf{V}_{\mathrm{within}}}.
#'   }
#'   \item{between}{
#'     Covariance between imputations
#'     \eqn{\mathbf{V}_{\mathrm{between}}}.
#'   }
#'   \item{total}{
#'     Total covariance matrix
#'     \eqn{\mathbf{V}_{\mathrm{total}}}.
#'   }
#'   \item{total_adjusted}{
#'     Adjusted total covariance matrix
#'     \eqn{\tilde{\mathbf{V}}_{\mathrm{total}}}.
#'   }
#'   \item{ariv}{
#'     Average relative increase in variance
#'     \eqn{\mathrm{ARIV}}.
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
#'
#' @export
#' @family Multiple Imputation Functions
#' @keywords manMCMedMiss mi
MICombine <- function(param_vec,
                      var_mat) {
  stopifnot(
    is.list(param_vec),
    is.list(var_mat)
  )
  m <- length(param_vec)
  k <- length(param_vec[[1]])
  dims <- dim(var_mat[[1]])
  stopifnot(
    m == length(var_mat),
    dims[1] == dims[2],
    k == dims[1]
  )
  estimates <- (
    1 / length(param_vec)
  ) * Reduce(
    f = `+`,
    x = param_vec
  )
  within <- (
    1 / m
  ) * Reduce(
    f = `+`,
    x = var_mat
  )
  between <- (
    1 / (
      m - 1
    )
  ) * Reduce(
    f = `+`,
    x = lapply(
      X = param_vec,
      FUN = function(i, estimates) {
        tcrossprod(i - estimates)
      },
      estimates = estimates
    )
  )
  colnames(between) <- rownames(between) <- rownames(within)
  # total parameter covariance matrix
  total <- within + between + (1 / m) * between
  # average relative increase in variance
  # Li, Raghunathan, and Rubin (1991)
  ariv <- (
    (
      1 + (
        1 / m
      )
    ) * sum(
      diag(
        between %*% solve(
          within
        )
      )
    )
  ) / k
  total_adjusted <- (1 + ariv) * within
  return(
    list(
      m = m,
      k = k,
      estimates = estimates,
      within = within,
      between = between,
      total = total,
      total_adjusted = total_adjusted,
      ariv = ariv
    )
  )
}
