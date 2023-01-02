#' Check Replication - SimAmputeData
#'
#' @details This function is executed via the `Check` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss gendata mediation ampute check
CheckAmputeData <- function(taskid,
                            repid,
                            output_folder,
                            suffix) {
  # Do not include default arguments here.
  # All arguments should be set by the `Check` function.
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
      overwrite = FALSE,
      integrity = TRUE
    )
    if (run) {
      return(
        basename(output_fn)
      )
    } else {
      return(NA)
    }
  }
  out <- matrix(
    data = NA,
    nrow = length(mechs),
    ncol = length(props)
  )
  for (i in seq_along(mechs)) {
    for (j in seq_along(props)) {
      out[i, j] <- foo(
        mech = mechs[i],
        prop = props[j],
        suffix = suffix
      )
    }
  }
  return(
    .Vec(out)
  )
}
