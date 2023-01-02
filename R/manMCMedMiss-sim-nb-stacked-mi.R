#' Simulation Replication - NBStackedMI
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss ci mediation mi simulation
SimNBStackedMI <- function(taskid,
                           repid,
                           output_folder,
                           seed,
                           suffix,
                           overwrite,
                           integrity,
                           B,
                           alpha) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
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
  nb_stacked_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "nb-stackedmi",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_mi_fn)) {
    run <- .SimCheck(
      fn = nb_stacked_mi_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(nb_stacked_mi_fn[i])
      saveRDS(
        object = NBStackedMI(
          data_mi = readRDS(
            file = data_mi_fn[i]
          ),
          B = B,
          alpha = alpha
        ),
        file = con
      )
      close(con)
      .SimChMod(nb_stacked_mi_fn[i])
    }
  }
}
