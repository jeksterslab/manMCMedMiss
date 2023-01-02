#' Simulation Replication - JointSigMI
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss test mediation mi simulation
SimJointSigMI <- function(taskid,
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
  sig_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "sig-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(fit_mi_fn)) {
    run <- .SimCheck(
      fn = sig_mi_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(sig_mi_fn[i])
      saveRDS(
        object = JointSigMI(
          fit_mi = readRDS(
            file = fit_mi_fn[i]
          ),
          alpha = alpha
        ),
        file = con
      )
      close(con)
      .SimChMod(sig_mi_fn[i])
    }
  }
}
