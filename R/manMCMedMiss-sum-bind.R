#' Bind Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a dataframe of results and parameters.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss summary
SumBind <- function(tasks,
                    output_folder,
                    data_raw_folder,
                    params) {
  output <- do.call(
    what = "rbind",
    args = lapply(
      X = seq_len(tasks),
      FUN = function(taskid,
                     output_folder) {
        summary_output <- readRDS(
          file = file.path(
            file.path(
              output_folder,
              paste0(
                SimProj(),
                "-",
                sprintf(
                  "%05d",
                  taskid
                )
              )
            ),
            paste0(
              SimProj(),
              "-",
              .SimSuffix(
                taskid = taskid,
                repid = NULL
              )
            )
          )
        )
        do.call(
          what = "rbind",
          args = lapply(
            X = summary_output,
            FUN = SumHit,
            params_taskid = params[which(params$taskid == taskid), ]
          )
        )
      },
      output_folder = output_folder
    )
  )
  rownames(output) <- 1:(dim(output)[1])
  fn <- file.path(
    data_raw_folder,
    paste0(
      SimProj(),
      ".Rds"
    )
  )
  con <- xzfile(
    description = fn,
    compression = 9L
  )
  saveRDS(
    object = output,
    file = con
  )
  close(con)
  .SimChMod(fn)
}
