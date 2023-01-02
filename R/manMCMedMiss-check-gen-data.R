#' Check Replication - SimGenData
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss gendata mediation normal check
CheckGenData <- function(taskid,
                         repid,
                         output_folder,
                         suffix) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Check` function.
  data_fn <- SimFN(
    data_type = "complete-00",
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  run <- .SimCheck(
    fn = data_fn,
    overwrite = FALSE,
    integrity = TRUE
  )
  if (run) {
    return(
      basename(data_fn)
    )
  } else {
    return(NA)
  }
}
