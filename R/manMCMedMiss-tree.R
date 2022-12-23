#' Conditional Inference Tree
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param alpha Significance level used for splitting.
#' @param maxdepth maximum depth of the tree.
#'   The default `maxdepth = 0`
#'   means that no restrictions are applied to tree sizes.
#' @param dichotomize Logical.
#'   Dichotomize the outcome variable into `robust = TRUE` and `robust = FALSE`.
#' @return Returns the result of `party::ctree()`.
#'
#' @inheritParams TabDescribe
#' @importFrom party ctree ctree_control
#' @export
#' @family Conditional Inference Tree Functions
#' @keywords manMCMedMiss tree
Tree <- function(results,
                 type,
                 alpha = 0.0001,
                 maxdepth = 0,
                 dichotomize = TRUE) {
  stopifnot(
    type %in% c("type1", "power", "miss")
  )
  data <- results
  data$taskid <- NULL
  data$replications <- NULL
  data$zero_hit <- NULL
  data$theta_hit <- NULL
  data$sigmasqepsilonm <- NULL
  data$sigmasqepsilony <- NULL
  if (type == "type1") {
    data <- data[
      which(data$alphabeta == 0),
    ]
    data$y <- data$type1
    if (dichotomize) {
      data$y <- ifelse(
        test = 0.035 <= data$y & data$y <= 0.065,
        yes = TRUE,
        no = FALSE
      )
    }
    data$type1 <- NULL
    data$power <- NULL
    data$miss <- NULL
  }
  if (type == "power") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    data$y <- data$power
    if (dichotomize) {
      data$y <- ifelse(
        test = data$y >= .80,
        yes = TRUE,
        no = FALSE
      )
    }
    data$type1 <- NULL
    data$power <- NULL
    data$miss <- NULL
  }
  if (type == "miss") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    data$y <- data$miss
    if (dichotomize) {
      data$y <- ifelse(
        test = 0.035 <= data$y & data$y <= 0.065,
        yes = TRUE,
        no = FALSE
      )
    }
    data$type1 <- NULL
    data$power <- NULL
    data$miss <- NULL
  }
  data <- data[
    stats::complete.cases(data),
  ]
  data$method <- droplevels(
    data$method
  )
  data$alphabeta <- as.factor(
    paste0(
      .FormatNum(data$alpha * data$beta),
      "(",
      .FormatNum(data$alpha),
      ",",
      .FormatNum(data$beta),
      ")"
    )
  )
  data$alpha <- NULL
  data$beta <- NULL
  return(
    party::ctree(
      formula = y ~ .,
      data = data,
      controls = party::ctree_control(
        mincriterion = 1 - alpha,
        maxdepth = maxdepth
      )
    )
  )
}
