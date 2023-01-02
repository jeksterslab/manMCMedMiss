#' Summarize Simulations - SimNBStackedMI
#'
#' @details This function is executed via the `Sum` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss ci mediation mi simulation summary
SumNBStackedMI <- function(taskid,
                           reps,
                           output_folder,
                           params_taskid) {
  # Summary is limited to alpha = 0.05
  foo <- function(repid,
                  taskid,
                  output_folder,
                  params_taskid) {
    suffix <- .SimSuffix(
      taskid = taskid,
      repid = repid
    )
    data_type <- c(
      "mar-30",
      "mar-20",
      "mar-10",
      "mcar-30",
      "mcar-20",
      "mcar-10"
    )
    do.call(
      what = "rbind",
      args = lapply(
        X = data_type,
        FUN = function(data_type,
                       taskid,
                       output_folder,
                       suffix,
                       params_taskid) {
          out <- readRDS(
            file = SimFN(
              data_type = data_type,
              output_type = "nb-stackedmi",
              output_folder = output_folder,
              suffix = suffix
            )
          )
          rownames(out) <- toupper(
            paste0(
              data_type,
              "-",
              paste0(
                "NB",
                rownames(out),
                ".",
                "StackedMI"
              )
            )
          )
          zero_hit <- .SimHit(
            lower = out[, "2.5%"],
            upper = out[, "97.5%"],
            theta = 0
          )
          theta_hit <- .SimHit(
            lower = out[, "2.5%"],
            upper = out[, "97.5%"],
            theta = params_taskid$alphabeta
          )
          cbind(
            out,
            zero_hit,
            theta_hit
          )
        },
        taskid = taskid,
        output_folder = output_folder,
        suffix = suffix,
        params_taskid = params_taskid
      )
    )
  }
  out <- (
    1 / reps
  ) * Reduce(
    f = `+`,
    x = lapply(
      X = seq_len(reps),
      FUN = foo,
      taskid = taskid,
      output_folder = output_folder,
      params_taskid = params_taskid
    )
  )
  return(
    cbind(
      out,
      replications = reps
    )
  )
}
