#' Joint Significance Test for the Indirect Effect
#' using Normal Theory Maximum Likelihood
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Note the `1` corresponds to a significant result and `0` otherwise.
#' The output vector's name corresponds to the `alpha` level.
#'
#' @inheritParams Template
#' @export
#' @family Significance Test Functions
#' @keywords manMCMedMiss test mediation ml
JointSigML <- function(fit_ml,
                       alpha = c(0.05, 0.01, 0.001)) {
  p <- .CIWald(
    est = fit_ml$coef,
    se = sqrt(diag(fit_ml$vcov)),
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
  return(out)
}
