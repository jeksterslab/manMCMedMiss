#' Nonparametric Bootstrap Confidence Intervals for the Indirect Effect
#' using Normal Theory Maximum Likelihood
#' (ML nested within NB or NB(ML))
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Nonparametric bootstrap confidence intervals.
#'   `bc` corresponds to bias-corrected and `pc` corresponds to percentile
#'  confidence intervals.
#'
#' @inheritParams Template
#' @export
#' @family Confidence Interval Functions
#' @keywords manMCMedMiss ci mediation ml
NBML <- function(data,
                 B = 5000L,
                 mplus_bin) {
  wd <- getwd()
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
        fn_inp_bc,
        fn_out_bc,
        fn_inp_pc,
        fn_out_pc
      )
    ),
    add = TRUE
  )
  data <- as.data.frame(data)
  missing <- any(is.na(data))
  if (missing) {
    data[is.na(data)] <- -999
  }
  fn_data <- tempfile()
  utils::write.table(
    data,
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
  input_analysis <- paste0(
    "ANALYSIS:", "\n",
    "TYPE = GENERAL;", "\n",
    "ESTIMATOR = ML;", "\n",
    "BOOTSTRAP = ", B, ";", "\n"
  )
  input_model <- paste0(
    "MODEL:", "\n",
    "Y ON X;", "\n",
    "Y ON M (B);", "\n",
    "M ON X (A);", "\n",
    "X WITH X;", "\n",
    "MODEL CONSTRAINT:", "\n",
    "NEW(AB);", "\n",
    "AB = A*B;", "\n"
  )
  if (missing) {
    input_variable <- paste0(
      input_variable,
      "MISSING = ALL (-999);", "\n"
    )
  }
  input <- paste0(
    input_data,
    input_variable,
    input_analysis,
    input_model
  )
  # BC
  input_bc <- paste0(
    input,
    "OUTPUT:", "\n",
    "CINT(bcbootstrap);", "\n"
  )
  fn_inp_bc <- tempfile()
  con <- file(fn_inp_bc)
  writeLines(input_bc, con)
  close(con)
  fn_out_bc <- tempfile()
  system(
    paste(
      "cd",
      tmp,
      ";",
      mplus_bin,
      fn_inp_bc,
      fn_out_bc
    ),
    ignore.stdout = TRUE,
    ignore.stderr = TRUE
  )
  bc <- grep(
    pattern = "[[:space:]]AB[[:space:]]",
    x = readLines(fn_out_bc),
    value = TRUE
  )[3]
  bc <- sub(
    pattern = "^[[:space:]]+AB[[:space:]]+",
    replacement = "",
    x = bc
  )
  bc <- as.numeric(
    unlist(
      strsplit(
        gsub(
          pattern = "[[:space:]]+",
          replacement = ",",
          x = bc,
          perl = TRUE
        ),
        split = ","
      )
    )
  )
  # PC
  input_pc <- paste0(
    input,
    "OUTPUT:", "\n",
    "CINT(bootstrap);", "\n"
  )
  fn_inp_pc <- tempfile()
  con <- file(fn_inp_pc)
  writeLines(input_pc, con)
  close(con)
  fn_out_pc <- tempfile()
  system(
    paste(
      "cd",
      tmp,
      ";",
      mplus_bin,
      fn_inp_pc,
      fn_out_pc
    ),
    ignore.stdout = TRUE,
    ignore.stderr = TRUE
  )
  pc <- grep(
    pattern = "[[:space:]]AB[[:space:]]",
    x = readLines(fn_out_pc),
    value = TRUE
  )[3]
  pc <- sub(
    pattern = "^[[:space:]]+AB[[:space:]]+",
    replacement = "",
    x = pc
  )
  pc <- as.numeric(
    unlist(
      strsplit(
        gsub(
          pattern = "[[:space:]]+",
          replacement = ",",
          x = pc,
          perl = TRUE
        ),
        split = ","
      )
    )
  )
  out <- rbind(
    bc,
    pc
  )
  colnames(out) <- c(
    "Lower .5%",
    "Lower 2.5%",
    "Lower 5%",
    "Estimate",
    "Upper 5%",
    "Upper 2.5%",
    "Upper .5%"
  )
  return(out)
}
