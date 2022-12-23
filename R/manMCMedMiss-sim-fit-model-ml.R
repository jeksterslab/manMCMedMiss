#' Simulation Replication - FitModelML
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss fit mediation ml simulation
SimFitModelML <- function(taskid,
                          repid,
                          output_folder,
                          seed,
                          suffix,
                          overwrite,
                          integrity,
                          mplus_bin) {
  # Do not include default arguments here.
  # All arguments should be set by the `Sim` function.
  data_type <- c(
    "complete-00",
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  data_fn <- SimFN(
    data_type = data_type,
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  fit_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "fit-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_fn)) {
    run <- .SimCheck(
      fn = fit_ml_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(fit_ml_fn[i])
      saveRDS(
        object = FitModelML(
          data = readRDS(
            file = data_fn[i]
          ),
          mplus_bin = mplus_bin
        ),
        file = con
      )
      close(con)
      .SimChMod(fit_ml_fn[i])
    }
  }
}
