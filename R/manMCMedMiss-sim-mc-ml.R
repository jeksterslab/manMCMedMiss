#' Simulation Replication - MCML
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss ci mediation ml simulation
SimMCML <- function(taskid,
                    repid,
                    output_folder,
                    seed,
                    suffix,
                    overwrite,
                    integrity,
                    R,
                    alpha) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
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
  mc_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "mc-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(fit_ml_fn)) {
    run <- .SimCheck(
      fn = mc_ml_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(mc_ml_fn[i])
      saveRDS(
        object = MCML(
          fit_ml = readRDS(
            file = fit_ml_fn[i]
          ),
          R = R,
          alpha = alpha
        ),
        file = con
      )
      close(con)
      .SimChMod(mc_ml_fn[i])
    }
  }
}
