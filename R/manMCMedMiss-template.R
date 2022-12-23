#' @param n Positive integer.
#'   Sample size.
#' @param tauprime Numeric.
#'   \eqn{\tau^{\prime}}, that is,
#'   the slope for \eqn{Y} regressed on \eqn{X}, adjusting for \eqn{M}.
#' @param beta Numeric.
#'   \eqn{\beta}, that is,
#'   the slope for \eqn{Y} regressed on \eqn{M}, adjusting for \eqn{X}.
#' @param alpha Numeric.
#'   \eqn{\alpha}, that is,
#'   the slope for \eqn{M} regressed on \eqn{X}.
#' @param mu Numeric.
#'   Common mean for \eqn{X}, \eqn{M}, and \eqn{Y},
#'   that is, \eqn{\mu_{X} = \mu_{M} = \mu_{Y}}.
#' @param sigmasq Numeric.
#'   Common variance for \eqn{X}, \eqn{M}, and \eqn{Y},
#'   that is, \eqn{\sigma^{2}_{X} = \sigma^{2}_{M} = \sigma^{2}_{Y}}.
#' @param data Numeric matrix.
#'   Output of the `GenData` or `AmputeData` functions.
#' @param data_complete Numeric matrix.
#'   Output of the `GenData` function
#'   or a three-column data set with complete data.
#' @param data_missing Numeric matrix.
#'   Output of the `AmputeData` function
#'   or a three-column data set with missing data.
#' @param data_mi List of numeric matrices.
#'   Output of the `ImputeData` function
#'   or a list of three-column data sets with imputed data.
#' @param mech Missing data mechanism.
#' @param prop Proportion of missing data.
#' @param patterns Numeric matrix consisting of zeroes and ones.
#'   Each row in the matrix represents a missing data pattern
#'   where 0 indicates a missing observation.
#'   If `patterns = NULL`,
#'   the default value is all possible missing data patterns
#'   for a data set with 3 columns.
#' @param m Positive integer.
#'   Number of imputations.
#' @param mplus_bin Character string.
#'   Path of Mplus binary.
#' @param consistent Logical.
#'   If `consistent = TRUE`,
#'   use the consistent estimate of the covariance matrix
#'   (maximum likelihood estimator).
#'   If `consistent = FALSE`,
#'   use the unbiased estimate of the covariance matrix.
#' @param fit_mi Object.
#'   Output of the `FitModelMI` function.
#' @param fit_ml Object.
#'   Output of the `FitModelML` function.
#' @param alpha Numeric vector.
#'   Significance level.
#' @param R Positive integer.
#'   Number of Monte Carlo replications.
#' @param B Positive integer.
#'   Number of bootstrap samples.
#' @param taskid Positive integer.
#'   Task ID.
#' @param repid Positive integer.
#'   Replication ID.
#' @param tasks Positive integer.
#'   Number of simulations tasks or cases.
#' @param reps Positive integer.
#'   Number of replications.
#' @param taskids Vector of taskids.
#' @param repids Vector of repids.
#' @param output_folder Character string.
#'   Output folder.
#' @param data_raw_folder Character string.
#'   `data-raw` folder in the project directory.
#' @param seed Integer.
#'   Random seed.
#' @param suffix Character string.
#'   Output of `manMCMedMiss:::.SimSuffix()`.
#' @param overwrite Logical.
#'   Overwrite existing output in `output_folder`.
#' @param integrity Logical.
#'   If `integrity = TRUE`,
#'   check for the output file integrity when `overwrite = FALSE`.
#' @param params_taskid Data frame with a single row.
#'   Simulation parameters for a specific `taskid`.
#' @param params Data frame.
#'   Simulation parameters for all simulation tasks or cases.
#' @param data_type Character string.
#'   Input data type.
#'   Valid values include
#'   `"complete-00"`,
#'   `"mar-30"`,
#'   `"mar-20"`,
#'   `"mar-10"`,
#'   `"mcar-30"`,
#'   `"mcar-20"`, and
#'   `"mcar-10"`
#' @param output_type Character string.
#'   Output type.
#'   Valid values include
#'   `"data"`,
#'   `"fit-mi"`,
#'   `"fit-ml"`,
#'   `"mc-mi"`,
#'   `"mc-ml"`,
#'   `"mi-nb"`,
#'   `"nb-mi"`,
#'   `"nb-ml"`,
#'   `"sig-mi"`,
#'   `"sig-ml"`, and
#'   `"stackedmi-nb"`
#' @param summary_output Numeric matrix.
#'   Output of `Sum*` functions.
#' @param nbmi Logical.
#'   If `nbmi = TRUE`, include `MINB`, `NBMI`, and `StackedMINB`.
#'
#' @name Template
NULL
