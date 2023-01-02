#' Simulation Replication - FitModelMI
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss fit mediation mi simulation
SimFitModelMI <- function(taskid,
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
    "mar-30",
    "mar-20",
    "mar-10",
    "mcar-30",
    "mcar-20",
    "mcar-10"
  )
  data_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "data-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  fit_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "fit-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_mi_fn)) {
    run <- .SimCheck(
      fn = fit_mi_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(fit_mi_fn[i])
      saveRDS(
        object = FitModelMI(
          data_mi = readRDS(
            file = data_mi_fn[i]
          ),
          mplus_bin = mplus_bin
        ),
        file = con
      )
      close(con)
      .SimChMod(fit_mi_fn[i])
    }
  }
}
