#' Simulation Replication - NBML
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
SimNBML <- function(taskid,
                    repid,
                    output_folder,
                    seed,
                    suffix,
                    overwrite,
                    integrity,
                    B,
                    mplus_bin) {
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
  data_fn <- SimFN(
    data_type = data_type,
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  nb_ml_fn <- SimFN(
    data_type = data_type,
    output_type = "nb-ml",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_fn)) {
    run <- .SimCheck(
      fn = nb_ml_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(nb_ml_fn[i])
      saveRDS(
        object = NBML(
          data = readRDS(
            file = data_fn[i]
          ),
          B = B,
          mplus_bin = mplus_bin
        ),
        file = con
      )
      close(con)
      .SimChMod(nb_ml_fn[i])
    }
  }
}
