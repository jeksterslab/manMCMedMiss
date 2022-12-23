#' Check Replication - SimNBMI
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss ci mediation mi check
CheckNBMI <- function(taskid,
                      repid,
                      output_folder,
                      suffix) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Check` function.
  data_type <- c(
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  nb_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "nb-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  out <- rep(
    x = NA,
    times = length(nb_mi_fn)
  )
  for (i in seq_along(nb_mi_fn)) {
    run <- .SimCheck(
      fn = nb_mi_fn[i],
      overwrite = FALSE,
      integrity = TRUE
    )
    if (run) {
      out[i] <- basename(nb_mi_fn[i])
    }
  }
  return(out)
}
