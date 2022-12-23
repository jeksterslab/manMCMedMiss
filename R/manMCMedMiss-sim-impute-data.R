#' Simulation Replication - ImputeData
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss gendata impute check simulation
SimImputeData <- function(taskid,
                          repid,
                          output_folder,
                          seed,
                          suffix,
                          overwrite,
                          integrity,
                          m,
                          mplus_bin) {
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
  data_fn <- SimFN(
    data_type = data_type,
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  data_mi_fn <- SimFN(
    data_type = data_type,
    output_type = "data-mi",
    output_folder = output_folder,
    suffix = suffix
  )
  for (i in seq_along(data_fn)) {
    run <- .SimCheck(
      fn = data_mi_fn[i],
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      set.seed(seed)
      con <- file(data_mi_fn[i])
      saveRDS(
        object = ImputeData(
          data_missing = readRDS(data_fn[i]),
          m = m,
          mplus_bin = mplus_bin
        ),
        file = con
      )
      close(con)
      .SimChMod(data_mi_fn[i])
    }
  }
}
