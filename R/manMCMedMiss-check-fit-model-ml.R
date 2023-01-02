#' Check Replication - SimFitModelML
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss fit mediation ml check
CheckFitModelML <- function(taskid,
                            repid,
                            output_folder,
                            suffix) {
  # Do not include default arguments here.
  # All arguments should be set by the `Check` function.
  data_type <- c(
    "complete-00",
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  fit_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "fit-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  out <- rep(
    x = NA,
    times = length(fit_ml_fn)
  )
  for (i in seq_along(fit_ml_fn)) {
    run <- .SimCheck(
      fn = fit_ml_fn[i],
      overwrite = FALSE,
      integrity = TRUE
    )
    if (run) {
      out[i] <- basename(fit_ml_fn[i])
    }
  }
  return(out)
}
