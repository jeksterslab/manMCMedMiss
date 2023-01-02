#' Simulation Parameters
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @format A dataframe with 472 rows and 7 columns:
#'
#' \describe{
#'   \item{taskid}{
#'     Simulation Task ID.
#'   }
#'   \item{tauprime}{
#'     \eqn{\tau^{\prime}}, that is,
#'     the path from \eqn{X} to \eqn{Y}, adjusting for \eqn{M}.
#'   }
#'   \item{beta}{
#'     \eqn{\beta}, that is,
#'     the path from \eqn{M} to \eqn{Y}.
#'   }
#'   \item{alpha}{
#'     \eqn{\alpha}, that is,
#'     the path from \eqn{X} to \eqn{M}.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{sigmasqepsilonm}{
#'     Error variance \eqn{\sigma^{2}_{\varepsilon_{M}}}.
#'   }
#'   \item{sigmasqepsilony}{
#'     Error variance \eqn{\sigma^{2}_{\varepsilon_{Y}}}.
#'   }
#'   \item{alphabeta}{
#'     \eqn{\alpha \beta}, that is,
#'     the indirect effect of \eqn{X} on \eqn{Y} via \eqn{M}.
#'   }
#' }
#'
#' @keywords data parameters
"params"
