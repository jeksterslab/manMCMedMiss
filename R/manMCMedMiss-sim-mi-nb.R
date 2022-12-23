#' Simulation Replication - MINB
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
SimMINB <- function(taskid,
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
  mi_nb_fn <- SimFN(
    data_type = data_type,
    output_type = "mi-nb",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_mi_fn)) {
    run <- .SimCheck(
      fn = mi_nb_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(mi_nb_fn[i])
      saveRDS(
        object = MINB(
          data_mi = readRDS(
            file = data_mi_fn[i]
          ),
          B = B,
          alpha = alpha
        ),
        file = con
      )
      close(con)
      .SimChMod(mi_nb_fn[i])
    }
  }
}
