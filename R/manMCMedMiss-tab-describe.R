#' Descriptive Statistics of Type I Error Rate, Statistical Power, and Miss Rate
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a table of means (`M`),
#'   standard deviations (`SD`), and
#'   row counts (`N`).
#'
#' @param results Data frame.
#'   The package data frame `results()`.
#' @param type Character string.
#'   Type of results to plot.
#'   Valid values are `"type1"`, `"power"`, and `"miss"`
#'   for Type I error rate, statistical power, and miss rate, respectively.
#' @param mech Character string.
#'   Missing data mechanism.
#'   Valid values are `"COMPLETE"`, `"MAR"`, and `"MCAR"`.
#' @param prop Numeric.
#'   Proportion of missing data.
#'   Valid values are `.1`, `.2`, `.3`.
#'   Note that if `mech = "COMPLETE"`, `prop` will be set to `0`.
#' @param n Vector of positive integers.
#'   Sample size.
#'   Valid values are `50`, `75`, `100`, `150`, `200`, `250`, `500`, and `1000`.
#'   If `n = NULL`, use all sample sizes.
#' @export
#' @family Table Functions
#' @keywords manMCMedMiss table
TabDescribe <- function(results,
                        type,
                        mech,
                        prop,
                        n = NULL) {
  stopifnot(
    mech %in% c("COMPLETE", "MAR", "MCAR")
  )
  stopifnot(
    type %in% c("type1", "power", "miss")
  )
  if (mech == "COMPLETE") {
    prop <- 0
  }
  stopifnot(
    prop %in% c(0, .1, .2, .3)
  )
  data <- results
  data$zero_hit <- NULL
  data$theta_hit <- NULL
  data <- data[
    which(results$mechanism == mech),
  ]
  data <- data[
    which(data$proportion == prop),
  ]
  if (!is.null(n)) {
    stopifnot(
      any(
        n %in% c(
          50,
          75,
          100,
          150,
          200,
          250,
          500,
          1000
        )
      )
    )
    data <- data[
      which(data$n %in% n),
    ]
  }
  if (type == "type1") {
    data <- data[
      which(data$alphabeta == 0),
    ]
    data$power <- NULL
    data$miss <- NULL
  }
  if (type == "power") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    data$type1 <- NULL
    data$miss <- NULL
  }
  if (type == "miss") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    data$type1 <- NULL
    data$power <- NULL
  }
  data <- data[
    stats::complete.cases(data),
  ]
  data$method <- droplevels(
    data$method
  )
  if (type == "type1") {
    mu <- stats::aggregate(
      x = data$type1,
      by = list(
        Method = data$method
      ),
      FUN = mean
    )
    sigma <- stats::aggregate(
      x = data$type1,
      by = list(
        Method = data$method
      ),
      FUN = stats::sd
    )
    n <- stats::aggregate(
      x = data$type1,
      by = list(
        Method = data$method
      ),
      FUN = length
    )
  }
  if (type == "power") {
    mu <- stats::aggregate(
      x = data$power,
      by = list(
        Method = data$method
      ),
      FUN = mean
    )
    sigma <- stats::aggregate(
      x = data$power,
      by = list(
        Method = data$method
      ),
      FUN = stats::sd
    )
    n <- stats::aggregate(
      x = data$power,
      by = list(
        Method = data$method
      ),
      FUN = length
    )
  }
  if (type == "miss") {
    mu <- stats::aggregate(
      x = data$miss,
      by = list(
        Method = data$method
      ),
      FUN = mean
    )
    sigma <- stats::aggregate(
      x = data$miss,
      by = list(
        Method = data$method
      ),
      FUN = stats::sd
    )
    n <- stats::aggregate(
      x = data$miss,
      by = list(
        Method = data$method
      ),
      FUN = length
    )
  }
  out <- cbind(
    mu,
    sigma[, 2],
    n[, 2]
  )
  colnames(out) <- c(
    "Method",
    "M",
    "SD",
    "N"
  )
  return(out)
}
