#' Box Plot of Type I Error Rate, Statistical Power, and Miss Rate
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a `ggplot2` plot object.
#'
#' @inheritParams TabDescribe
#' @export
#' @family Figure Functions
#' @keywords manMCMedMiss figure
FigBoxPlot <- function(results,
                       type,
                       mech,
                       prop,
                       n = NULL) {
  type1 <- power <- miss <- method <- NULL
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
    ylab <- "Type I Error Rate"
    data$power <- NULL
    data$miss <- NULL
  }
  if (type == "power") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    ylab <- "Statistical Power"
    data$type1 <- NULL
    data$miss <- NULL
  }
  if (type == "miss") {
    data <- data[
      which(data$alphabeta > 0),
    ]
    ylab <- "Miss Rate"
    data$type1 <- NULL
    data$power <- NULL
  }
  data <- data[
    stats::complete.cases(data),
  ]
  data$method <- droplevels(
    data$method
  )
  data$method <- factor(
    data$method,
    levels = rev(
      levels(data$method)
    )
  )
  if (type == "type1") {
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(x = method, y = type1)
    ) +
      ggplot2::geom_boxplot() +
      ggplot2::geom_hline(
        yintercept = 0.05,
        linetype = "dashed",
        color = "red"
      ) +
      ggplot2::geom_hline(
        yintercept = 0.035,
        linetype = "dashed",
        color = "red"
      ) +
      ggplot2::geom_hline(
        yintercept = 0.065,
        linetype = "dashed",
        color = "red"
      )
  }
  if (type == "power") {
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(x = method, y = power)
    ) +
      ggplot2::geom_boxplot()
    if (min(data$power) < 0.80 && 0.80 < max(data$power)) {
      p <- p +
        ggplot2::geom_hline(
          yintercept = 0.80,
          linetype = "dashed",
          color = "red"
        )
    }
  }
  if (type == "miss") {
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(x = method, y = miss)
    ) +
      ggplot2::geom_boxplot() +
      ggplot2::geom_hline(
        yintercept = 0.05,
        linetype = "dashed",
        color = "red"
      ) +
      ggplot2::geom_hline(
        yintercept = 0.035,
        linetype = "dashed",
        color = "red"
      ) +
      ggplot2::geom_hline(
        yintercept = 0.065,
        linetype = "dashed",
        color = "red"
      )
  }
  return(
    p +
      ggplot2::ylab(
        ylab
      ) +
      ggplot2::xlab(
        "Method"
      ) +
      ggplot2::stat_summary(
        fun = "mean",
        color = "red",
        shape = 13
      ) +
      ggplot2::theme_bw() +
      ggplot2::coord_flip()
  )
}
