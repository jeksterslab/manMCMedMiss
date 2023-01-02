#' Extract Zero Hit and Theta Hit from Summary Output
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a dataframe of results and parameters.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss summary
SumHit <- function(summary_output,
                   params_taskid) {
  data_type <- rownames(summary_output)
  data_type <- strsplit(x = data_type, split = "-")
  data_type <- as.data.frame(
    do.call(
      what = "rbind",
      args = data_type
    )
  )
  colnames(data_type) <- c(
    "mechanism",
    "proportion",
    "method"
  )
  data_type$proportion <- as.numeric(data_type$proportion) * 0.01
  summary_output <- cbind(
    zero_hit = summary_output[, "zero_hit"],
    theta_hit = summary_output[, "theta_hit"],
    replications = summary_output[, "replications"],
    taskid = params_taskid$taskid,
    tauprime = params_taskid$tauprime,
    beta = params_taskid$beta,
    alpha = params_taskid$alpha,
    n = params_taskid$n,
    sigmasqepsilonm = params_taskid$sigmasqepsilonm,
    sigmasqepsilony = params_taskid$sigmasqepsilony,
    alphabeta = params_taskid$alphabeta
  )
  return(
    cbind(
      data.frame(summary_output),
      data_type
    )
  )
}
