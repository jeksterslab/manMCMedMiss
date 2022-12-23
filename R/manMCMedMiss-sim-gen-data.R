#' Simulation Replication - GenData
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss gendata mediation normal simulation
SimGenData <- function(taskid,
                       repid,
                       output_folder,
                       params_taskid,
                       seed,
                       suffix,
                       overwrite,
                       integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  data_fn <- SimFN(
    data_type = "complete-00",
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  run <- .SimCheck(
    fn = data_fn,
    overwrite = overwrite,
    integrity = integrity
  )
  if (run) {
    set.seed(seed)
    con <- file(data_fn)
    saveRDS(
      object = GenData(
        n = params_taskid$n,
        tauprime = params_taskid$tauprime,
        beta = params_taskid$beta,
        alpha = params_taskid$alpha
      ),
      file = con
    )
    close(con)
    .SimChMod(data_fn)
  }
}
