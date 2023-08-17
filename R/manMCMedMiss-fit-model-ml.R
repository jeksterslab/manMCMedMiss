#' Fit the Simple Mediation Model using Normal Theory Maximum Likelihood
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a list with the following elements:
#' \describe{
#'   \item{fit}{
#'     Model fit.
#'   }
#'   \item{coef}{
#'     Coefficients/parameter estimates
#'   }
#'   \item{vcov}{
#'     Sampling variance-covariance matrix.
#'   }
#'   \item{output}{
#'     Mplus output.
#'   }
#' }
#' Values in `fit`.
#' \describe{
#'   \item{free_parameters}{
#'     Number of free parameters
#'   }
#'   \item{h0_loglikelihood}{
#'     H0 loglikelihood.
#'   }
#'   \item{h1_loglikelihood}{
#'     H1 loglikelihood.
#'   }
#'   \item{aic}{
#'     Akaike information criterion (AIC).
#'   }
#'   \item{bic}{
#'     Bayesian information criterion (BIC).
#'   }
#'   \item{sabic}{
#'     Sample-size adjusted BIC (SABIC).
#'   }
#'   \item{chisq}{
#'     Chi-square value.
#'   }
#'   \item{chisq_df}{
#'     Chi-square degrees of freedom.
#'   }
#'   \item{chisq_p}{
#'     Chi-square p-value.
#'   }
#'   \item{cfi}{
#'     Comparative fit index (CFI).
#'   }
#'   \item{tli}{
#'     Tucker–Lewis index (TLI).
#'   }
#'   \item{rmsea}{
#'     Root mean square error of approximation (RMSEA)
#'     estimate.
#'   }
#'   \item{rmsea_low}{
#'     Root mean square error of approximation (RMSEA)
#'     lower limit confidence interval.
#'   }
#'   \item{rmsea_up}{
#'     Root mean square error of approximation (RMSEA)
#'     upper limit confidence interval.
#'   }
#'   \item{rmsea_p}{
#'     Root mean square error of approximation (RMSEA)
#'     probability.
#'   }
#'   \item{srmr}{
#'     Standardized root mean square residual (SRMR).
#'   }
#'   \item{condition_number}{
#'     Condition number for the information matrix
#'     (ratio of smallest to largest eigenvalue).
#'   }
#' }
#'
#' @inheritParams Template
#' @export
#' @family Model Fitting Functions
#' @keywords manMCMedMiss fit mediation ml
FitModelML <- function(data,
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
        fn_res,
        fn_vcov,
        fn_inp,
        fn_out
      )
    ),
    add = TRUE
  )
  missing <- any(is.na(data))
  if (missing) {
    data <- as.data.frame(data)
    data[is.na(data)] <- -999
  }
  fn_data <- tempfile()
  fn_res <- tempfile()
  fn_vcov <- tempfile()
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
    "ESTIMATOR = ML;", "\n"
  )
  input_model <- paste0(
    "MODEL:", "\n",
    "Y ON X;", "\n",
    "Y ON M (B);", "\n",
    "M ON X (A);", "\n",
    "X WITH X;", "\n"
  )
  input_savedata <- paste0(
    "SAVEDATA:", "\n",
    "RESULTS ARE ", basename(fn_res), ";", "\n",
    "TECH3 IS ", basename(fn_vcov), ";", "\n"
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
    input_model,
    input_savedata
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
  vcovs <- data.matrix(utils::read.table(fn_vcov))
  vcovs <- .SymofVech(
    c(
      vcovs[1, 1], vcovs[1, 2], vcovs[1, 4], vcovs[2, 2], vcovs[3, 1], vcovs[4, 1], vcovs[5, 2], vcovs[6, 4], vcovs[8, 2], # nolint
      vcovs[1, 3], vcovs[1, 5], vcovs[2, 3], vcovs[3, 2], vcovs[4, 2], vcovs[5, 3], vcovs[6, 5], vcovs[8, 3], # nolint
      vcovs[2, 1], vcovs[2, 4], vcovs[3, 3], vcovs[4, 3], vcovs[5, 4], vcovs[7, 1], vcovs[8, 4], # nolint
      vcovs[2, 5], vcovs[3, 4], vcovs[4, 4], vcovs[5, 5], vcovs[7, 2], vcovs[8, 5], # nolint
      vcovs[3, 5], vcovs[4, 5], vcovs[6, 1], vcovs[7, 3], vcovs[9, 1],
      vcovs[5, 1], vcovs[6, 2], vcovs[7, 4], vcovs[9, 2],
      vcovs[6, 3], vcovs[7, 5], vcovs[9, 3],
      vcovs[8, 1], vcovs[9, 4],
      vcovs[9, 5]
    ),
    k = 9
  )
  rownames(vcovs) <- colnames(vcovs) <- c(
    "m~1",
    "y~1",
    "x~1",
    "m~x",
    "y~m",
    "y~x",
    "m~~m",
    "y~~y",
    "x~~x"
  )
  results <- readLines(fn_res)
  coefs <- as.numeric(
    unlist(
      strsplit(results[1], split = " ")
    )
  )
  coefs <- coefs[
    stats::complete.cases(
      coefs
    )
  ]
  names(coefs) <- colnames(vcovs)
  fit1 <- as.numeric(
    unlist(
      strsplit(results[3], split = " ")
    )
  )
  fit1 <- fit1[
    stats::complete.cases(
      fit1
    )
  ]
  fit2 <- as.numeric(
    unlist(
      strsplit(results[4], split = " ")
    )
  )
  fit2 <- fit2[
    stats::complete.cases(
      fit2
    )
  ]
  fit <- c(
    fit1,
    fit2
  )
  names(fit) <- c(
    "free_parameters",
    "h0_loglikelihood",
    "h1_loglikelihood",
    "aic",
    "bic",
    "sabic",
    "chisq",
    "chisq_df",
    "chisq_p",
    "cfi",
    "tli",
    "rmsea",
    "rmsea_low",
    "rmsea_up",
    "rmsea_p",
    "srmr",
    "condition_number"
  )
  return(
    list(
      fit = fit,
      coef = coefs,
      vcov = vcovs,
      output = readLines(fn_out)
    )
  )
}
