#' Fit the Simple Mediation Model using Normal Theory Maximum Likelihood
#' (Indirect Effect)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns the indirect effect.
#'
#' @inheritParams Template
#' @export
#' @family Model Fitting Functions
#' @keywords manMCMedMiss fit mediation ml
FitModelIndirect <- function(data_complete,
                             consistent = TRUE) {
  stopifnot(!any(is.na(data_complete))) # assert complete data
  cov_mat <- stats::cov(data_complete)
  if (consistent) {
    n <- nrow(data_complete)
    cov_mat <- (
      n / (n - 1)
    ) * cov_mat
  }
  return(
    .Vec(
      (
        cov_mat[1, 2] / cov_mat[1, 1]
      ) * (
        (
          cov_mat[1, 1] * cov_mat[2, 3] - cov_mat[1, 2] * cov_mat[1, 3]
        ) / (
          cov_mat[1, 1] * cov_mat[2, 2] - cov_mat[1, 2]^2
        )
      )
    )
  )
}
