#' Simulation Hit
#'
#' Tests if `theta` is within the lower and upper limits of an interval.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a logical vector.
#'
#' @param lower Numeric vector.
#'   Lower limit.
#' @param upper Numeric vector.
#'   Upper limit.
#' @param theta Numeric.
#'   Parameter.
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimHit <- function(lower,
                    upper,
                    theta) {
  return(
    lower <= theta & theta <= upper
  )
}
