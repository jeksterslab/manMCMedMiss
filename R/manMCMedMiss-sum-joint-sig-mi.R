#' Summarize Simulations - SimJointSigMI
#'
#' @details This function is executed via the `Sum` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss test mediation mi summary
SumJointSigMI <- function(taskid,
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
              output_type = "sig-mi",
              output_folder = output_folder,
              suffix = suffix
            )
          )
          rownames(out) <- toupper(
            paste0(
              data_type,
              "-",
              paste0(
                "SIG",
                ".",
                ifelse(
                  test = rownames(out) == "vcov",
                  yes = "MI",
                  no = "MI.ADJ"
                )
              )
            )
          )
          cbind(
            out,
            zero_hit = !(out[, "0.05"]),
            theta_hit = NA
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
