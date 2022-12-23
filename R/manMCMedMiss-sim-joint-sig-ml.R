#' Simulation Replication - JointSigML
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss test mediation ml simulation
SimJointSigML <- function(taskid,
                          repid,
                          output_folder,
                          seed,
                          suffix,
                          overwrite,
                          integrity,
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
  sig_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "sig-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(fit_ml_fn)) {
    run <- .SimCheck(
      fn = sig_ml_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(sig_ml_fn[i])
      saveRDS(
        object = JointSigML(
          fit_ml = readRDS(
            file = fit_ml_fn[i]
          ),
          alpha = alpha
        ),
        file = con
      )
      close(con)
      .SimChMod(sig_ml_fn[i])
    }
  }
}
