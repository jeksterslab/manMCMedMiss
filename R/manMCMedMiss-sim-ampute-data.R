#' Simulation Replication - AmputeData
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss gendata mediation ampute simulation
SimAmputeData <- function(taskid,
                          repid,
                          output_folder,
                          seed,
                          suffix,
                          overwrite,
                          integrity) {
  # Do not include default arguments here.
  # All arguments should be set by the `Sim` function.
  data_fn <- SimFN(
    data_type = "complete-00",
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  mechs <- c(
    "MAR",
    "MCAR"
  )
  props <- c(
    0.30,
    0.20,
    0.10
  )
  foo <- function(mech,
                  prop,
                  seed,
                  suffix) {
    output_fn <- SimFN(
      data_type = paste0(
        tolower(mech),
        "-",
        as.integer(prop * 100)
      ),
      output_type = "data",
      output_folder = output_folder,
      suffix = suffix
    )
    run <- .SimCheck(
      fn = output_fn,
      overwrite = overwrite,
      integrity = integrity
    )
    if (run) {
      seed <- .SimSeed(
        taskid = taskid,
        repid = repid
      )
      set.seed(seed)
      out <- AmputeData(
        data_complete = readRDS(
          file = data_fn
        )
      )
      con <- file(output_fn)
      saveRDS(
        object = out,
        file = con
      )
      close(con)
      .SimChMod(output_fn)
    }
  }
  for (i in seq_along(mechs)) {
    for (j in seq_along(props)) {
      foo(
        mech = mechs[i],
        prop = props[j],
        seed = seed,
        suffix = suffix
      )
    }
  }
}
