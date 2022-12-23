#' Impute Data
#'
#' Generates `m` complete data sets using multiple imputation.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @references
#' Asparouhov, T., & Muthen, B. (2022).
#' *Multiple imputation with Mplus*.
#' Retrieved from \url{http://www.statmodel.com/download/Imputations7.pdf}
#'
#' @return Returns a list of complete data sets.
#'
#' @inheritParams Template
#' @export
#' @family Data Generation Functions
#' @keywords manMCMedMiss gendata impute
ImputeData <- function(data_missing,
                       m,
                       mplus_bin) {
  wd <- getwd()
  # long file paths can result in errors in Mplus
  # use basenames and cd to the directory
  tmp <- tempdir()
  setwd(tmp)
  on.exit(
    setwd(wd),
    add = TRUE
  )
  on.exit(
    unlink(
      c(
        fn_data,
        paste0(fn_imp, "*"),
        fn_inp,
        fn_out
      )
    ),
    add = TRUE
  )
  data_missing <- as.data.frame(data_missing)
  data_missing[is.na(data_missing)] <- -999
  fn_data <- tempfile()
  fn_imp <- tempfile()
  utils::write.table(
    data_missing,
    file = fn_data,
    row.names = FALSE,
    col.names = FALSE,
    sep = ","
  )
  input_data <- paste0(
    "DATA:", "\n",
    "FILE = ", basename(fn_data), ";", "\n"
  )
  input_variable <- paste0(
    "VARIABLE:", "\n",
    "NAMES = X M Y;", "\n",
    "USEVARIABLES = X M Y;", "\n"
  )
  input_variable <- paste0(
    input_variable,
    "MISSING = ALL (-999);", "\n"
  )
  input_analysis <- paste0(
    "ANALYSIS:", "\n",
    "TYPE = BASIC;", "\n"
  )
  input_imputation <- paste0(
    "DATA IMPUTATION:", "\n",
    "IMPUTE = X M Y;", "\n",
    "NDATASETS = ", m, ";", "\n",
    "SAVE = ", paste0(basename(fn_imp), "*.dat"), ";", "\n"
  )
  input <- paste0(
    input_data,
    input_variable,
    input_analysis,
    input_imputation
  )
  fn_inp <- tempfile()
  con <- file(fn_inp)
  writeLines(input, con)
  close(con)
  fn_out <- tempfile()
  system(
    paste(
      "cd",
      tmp,
      ";",
      mplus_bin,
      fn_inp,
      fn_out
    ),
    ignore.stdout = TRUE,
    ignore.stderr = TRUE
  )
  lapply(
    X = paste0(fn_imp, 1:m, ".dat"),
    FUN = utils::read.table
  )
}
