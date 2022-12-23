#' Check Replication - SimFitModelMI
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss fit mediation mi check
CheckFitModelMI <- function(taskid,
                            repid,
                            output_folder,
                            suffix) {
  # Do not include default arguments here.
  # All arguments should be set by the `Sim` function.
  data_type <- c(
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  fit_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "fit-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  out <- rep(
    x = NA,
    times = length(fit_mi_fn)
  )
  for (i in seq_along(fit_mi_fn)) {
    run <- .SimCheck(
      fn = fit_mi_fn[i],
      overwrite = FALSE,
      integrity = TRUE
    )
    if (run) {
      out[i] <- basename(fit_mi_fn[i])
    }
  }
  return(out)
}
