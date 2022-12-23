#' Joint Significance Test for the Indirect Effect using Multiple Imputation
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a list with the following elements:
#' \describe{
#'   \item{vcov}{
#'     Joint significance test based on the total covariance matrix.
#'   }
#'   \item{vcov_tilde}{
#'     Joint significance test based on the adjusted total covariance matrix.
#'   }
#' }
#' Note the `1` corresponds to a significant result and `0` otherwise.
#' The output vector's name corresponds to the `alpha` level.
#'
#' @inheritParams Template
#' @export
#' @family Significance Test Functions
#' @keywords manMCMedMiss test mediation mi
JointSigMI <- function(fit_mi,
                       alpha = c(0.05, 0.01, 0.001)) {
  foo <- function(vcov,
                  alpha) {
    p <- .CIWald(
      est = fit_mi$coef,
      se = sqrt(diag(vcov)),
      alpha = alpha,
      z = TRUE,
      test = TRUE
    )[c(5, 4), ]
    out <- colSums(
      do.call(
        what = "rbind",
        args = lapply(
          X = p[, "p"],
          FUN = function(p, alpha) {
            p < alpha
          },
          alpha = alpha
        )
      )
    )
    out <- ifelse(
      test = out == 2,
      yes = 1,
      no = 0
    )
    names(out) <- alpha
    out
  }
  return(
    rbind(
      vcov = foo(
        vcov = fit_mi$vcov,
        alpha = alpha
      ),
      vcov_tilde = foo(
        vcov = fit_mi$vcov_tilde,
        alpha = alpha
      )
    )
  )
}
