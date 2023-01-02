#' Check Replication
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns file names of replications that need to be run.
#'
#' @inheritParams Template
#' @export
#' @keywords manMCMedMiss check
Check <- function(taskids,
                  repids,
                  output_folder,
                  nbmi) {
  foo <- function(taskid,
                  repid,
                  output_folder) {
    # Add taskid to output_folder
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
    suffix <- .SimSuffix(
      taskid = taskid,
      repid = repid
    )
    out <- c(
      CheckGenData(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckAmputeData(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckImputeData(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckFitModelML(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckFitModelMI(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckJointSigMI(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckJointSigML(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckMCMI(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckMCML(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      ),
      CheckNBML(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        suffix = suffix
      )
    )
    if (nbmi) {
      out <- c(
        CheckMINB(
          taskid = taskid,
          repid = repid,
          output_folder = output_folder,
          suffix = suffix
        ),
        CheckNBMI(
          taskid = taskid,
          repid = repid,
          output_folder = output_folder,
          suffix = suffix
        ),
        CheckStackedMINB(
          taskid = taskid,
          repid = repid,
          output_folder = output_folder,
          suffix = suffix
        )
      )
    }
    return(out)
  }
  ids <- as.data.frame(
    t(
      ids <- expand.grid(
        taskids = taskids,
        repids = repids
      )
    )
  )
  out <- lapply(
    X = ids,
    FUN = function(id,
                   output_folder) {
      foo(
        taskid = id[1],
        repid = id[2],
        output_folder = output_folder
      )
    },
    output_folder = output_folder
  )
  out <- do.call(
    what = "rbind",
    args = out
  )
  return(
    out[
      stats::complete.cases(
        .Vec(out)
      )
    ]
  )
}
