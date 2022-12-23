data_process_params <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  params_file <- root$find_file(
    "data",
    "params.rda"
  )
  if (!file.exists(params_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    es <- c(
      0.00,
      0.02,
      0.13,
      0.26
    )
    alpha <- beta <- sqrt(sqrt(es))
    tauprime <- sqrt(es)
    n <- c(
      50,
      75,
      100,
      150,
      200,
      250,
      500,
      1000
    )
    params <- expand.grid(
      tauprime = tauprime,
      beta = beta,
      alpha = alpha,
      n = n
    )
    params$sigmasqepsilonm <- 1 - params$alpha^2
    params$sigmasqepsilony <- 1 - params$tauprime^2 - params$alpha^2 * params$beta^2 - params$beta^2 * (1 - params$alpha^2) - 2 * params$tauprime * params$beta * params$alpha
    params <- params[which(params$sigmasqepsilonm > 0), ]
    params <- params[which(params$sigmasqepsilony > 0), ]
    params <- data.frame(
      taskid = 1:(dim(params)[1]),
      params,
      alphabeta = params$alpha * params$beta
    )
    rownames(params) <- params$taskid
    save(
      params,
      file = params_file,
      compress = "xz"
    )
  }
}
data_process_params()
rm(data_process_params)
