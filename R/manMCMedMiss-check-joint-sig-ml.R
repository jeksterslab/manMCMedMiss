#' Check Replication - SimJointSigML
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss test mediation ml check
CheckJointSigML <- function(taskid,
                            repid,
                            output_folder,
                            suffix) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Check` function.
  data_type <- c(
    "complete-00",
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  sig_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "sig-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  out <- rep(
    x = NA,
    times = length(sig_ml_fn)
  )
  for (i in seq_along(sig_ml_fn)) {
    run <- .SimCheck(
      fn = sig_ml_fn[i],
      overwrite = FALSE,
      integrity = TRUE
    )
    if (run) {
      out[i] <- basename(sig_ml_fn[i])
    }
  }
  return(out)
}
