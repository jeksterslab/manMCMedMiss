#' Summarize Simulations
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss summary
Sum <- function(taskid,
                reps,
                output_folder,
                params_taskid,
                nbmi) {
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      sprintf(
        "%05d",
        taskid
      )
    )
  )
  if (!file.exists(output_folder)) {
    dir.create(
      path = output_folder,
      showWarnings = FALSE,
      recursive = TRUE
    )
    .SimChMod(output_folder)
  }
  fn <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      .SimSuffix(
        taskid = taskid,
        repid = NULL
      )
    )
  )
  con <- xzfile(
    description = fn,
    compression = 9L
  )
  out <- list(
    sig_mi = SumJointSigMI(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      params_taskid = params_taskid
    ),
    sig_ml = SumJointSigML(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      params_taskid = params_taskid
    ),
    mc_mi = SumMCMI(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      params_taskid = params_taskid
    ),
    mc_ml = SumMCML(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      params_taskid = params_taskid
    ),
    nb_ml = SumNBML(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      params_taskid = params_taskid
    )
  )
  if (nbmi) {
    nbmi <- list(
      mi_nb = SumMINB(
        taskid = taskid,
        reps = reps,
        output_folder = output_folder,
        params_taskid = params_taskid
      ),
      nb_mi = SumNBMI(
        taskid = taskid,
        reps = reps,
        output_folder = output_folder,
        params_taskid = params_taskid
      ),
      nb_stacked_mi = SumNBStackedMI(
        taskid = taskid,
        reps = reps,
        output_folder = output_folder,
        params_taskid = params_taskid
      )
    )
    out <- c(
      out,
      nbmi
    )
  }
  saveRDS(
    object = out,
    file = con
  )
  close(con)
  .SimChMod(fn)
}
