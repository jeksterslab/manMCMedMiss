#' Scatter Plot of Type I Error Rate, Statistical Power, and Miss Rate
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a `ggplot2` plot object.
#'
#' @inheritParams TabDescribe
#' @export
#' @family Figure Functions
#' @keywords manMCMedMiss figure
FigScatterPlot <- function(results,
                           type,
                           mech,
                           prop,
                           n = NULL) {
  alphabeta_label <- type1 <- Method <- miss <- power <- NULL
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
  data$Method <- data$method
  data <- data[which(data$mechanism == mech), ]
  data <- data[which(data$proportion == prop), ]
  data$alphabeta_label <- as.factor(
    paste0(
      .FormatNum(data$alpha * data$beta),
      "(",
      .FormatNum(data$alpha),
      ",",
      .FormatNum(data$beta),
      ")"
    )
  )
  data$tauprime_label <- as.factor(
    paste0(
      "\u03c4",
      "\u2032: ",
      .FormatNum(data$tauprime)
    )
  )
  data$n_label <- as.factor(
    paste0(
      "n:",
      data$n
    )
  )
  data$n_label <- factor(
    data$n_label,
    levels = c(
      "n:50",
      "n:75",
      "n:100",
      "n:150",
      "n:200",
      "n:250",
      "n:500",
      "n:1000"
    )
  )
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
  xlab <- "\u03b1\u03b2(\u03b1,\u03b2)"
  if (type == "type1") {
    data$alphabeta_label <- factor(
      data$alphabeta_label,
      levels = c(
        ".00(.00,.00)",
        ".00(.00,.38)",
        ".00(.38,.00)",
        ".00(.00,.60)",
        ".00(.60,.00)",
        ".00(.00,.71)",
        ".00(.71,.00)"
      )
    )
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(
        x = alphabeta_label,
        y = type1,
        shape = Method,
        color = Method,
        group = Method,
        linetype = Method
      )
    ) +
      ggplot2::geom_hline(
        yintercept = 0.05,
        alpha = 0.5
      ) +
      ggplot2::geom_hline(
        yintercept = 0.035,
        alpha = 0.5
      ) +
      ggplot2::geom_hline(
        yintercept = 0.065,
        alpha = 0.5
      ) +
      ggplot2::annotate(
        geom = "rect",
        fill = "grey",
        alpha = 0.75,
        xmin = -Inf,
        xmax = Inf,
        ymin = 0.035,
        ymax = 0.065
      ) +
      ggplot2::geom_point() +
      ggplot2::geom_line() +
      ggplot2::facet_grid(
        factor(
          tauprime_label,
          levels = rev(
            levels(
              tauprime_label
            )
          )
        ) ~ n_label
      ) +
      ggplot2::xlab(
        xlab
      ) +
      ggplot2::ylab(
        "Type I Error Rate"
      ) +
      ggplot2::theme_bw() +
      ggplot2::theme(
        axis.text.x = ggplot2::element_text(
          angle = -90,
          size = 8,
          vjust = 0.5
        )
      ) +
      ggplot2::scale_colour_viridis_d(option = "plasma") +
      ggplot2::scale_shape()
  }
  if (type == "miss") {
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(
        x = alphabeta_label,
        y = miss,
        shape = Method,
        color = Method,
        group = Method,
        linetype = Method
      )
    ) +
      ggplot2::geom_hline(
        yintercept = 0.05,
        alpha = 0.5
      ) +
      ggplot2::geom_hline(
        yintercept = 0.035,
        alpha = 0.5
      ) +
      ggplot2::geom_hline(
        yintercept = 0.065,
        alpha = 0.5
      ) +
      ggplot2::annotate(
        geom = "rect",
        fill = "grey",
        alpha = 0.75,
        xmin = -Inf,
        xmax = Inf,
        ymin = 0.035,
        ymax = 0.065
      ) +
      ggplot2::geom_point() +
      ggplot2::geom_line() +
      ggplot2::facet_grid(
        factor(
          tauprime_label,
          levels = rev(
            levels(
              tauprime_label
            )
          )
        ) ~ n_label
      ) +
      ggplot2::xlab(
        xlab
      ) +
      ggplot2::ylab(
        "Miss Rate"
      ) +
      ggplot2::theme_bw() +
      ggplot2::theme(
        axis.text.x = ggplot2::element_text(
          angle = -90,
          size = 8,
          vjust = 0.5
        )
      ) +
      ggplot2::scale_colour_viridis_d(option = "plasma") +
      ggplot2::scale_shape()
  }
  if (type == "power") {
    p <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(
        x = alphabeta_label,
        y = power,
        shape = Method,
        color = Method,
        group = Method,
        linetype = Method
      )
    ) +
      ggplot2::geom_hline(
        yintercept = 0.80,
        alpha = 0.5
      ) +
      ggplot2::geom_point() +
      ggplot2::geom_line() +
      ggplot2::facet_grid(
        factor(
          tauprime_label,
          levels = rev(
            levels(
              tauprime_label
            )
          )
        ) ~ n_label
      ) +
      ggplot2::xlab(
        xlab
      ) +
      ggplot2::ylab(
        "Statistical Power"
      ) +
      ggplot2::theme_bw() +
      ggplot2::theme(
        axis.text.x = ggplot2::element_text(
          angle = -90,
          size = 8,
          vjust = 0.5
        )
      ) +
      ggplot2::scale_colour_viridis_d(option = "plasma") +
      ggplot2::scale_shape()
  }
  return(p)
}
