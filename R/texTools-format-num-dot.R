#' Format Number
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @returns Returns a character string of formatted number.
#'
#' @param x Numeric.
#' @param digits Integer.
#'   Decimal places.
#' @param nozero Logical.
#'   If `TRUE`, no leading zeroes before the decimal point.
#'
#' @family Format Functions
#' @keywords texTools format internal
#' @noRd
.FormatNum <- function(x,
                       digits = 2,
                       nozero = TRUE) {
  y <- format(
    round(
      x,
      digits = digits
    ),
    nsmall = digits
  )
  if (nozero) {
    y <- sub("^0+", "", y)
    y <- sub("^-0+", "", y)
  }
  return(
    trimws(y)
  )
}
