% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manMCMedMiss-fit-model-indirect.R
\name{FitModelIndirect}
\alias{FitModelIndirect}
\title{Fit the Simple Mediation Model using Normal Theory Maximum Likelihood
(Indirect Effect)}
\usage{
FitModelIndirect(data_complete, consistent = TRUE)
}
\arguments{
\item{data_complete}{Numeric matrix.
Output of the \code{GenData} function
or a three-column data set with complete data.}

\item{consistent}{Logical.
If \code{consistent = TRUE},
use the consistent estimate of the covariance matrix
(maximum likelihood estimator).
If \code{consistent = FALSE},
use the unbiased estimate of the covariance matrix.}
}
\value{
Returns the indirect effect.
}
\description{
Fit the Simple Mediation Model using Normal Theory Maximum Likelihood
(Indirect Effect)
}
\seealso{
Other Model Fitting Functions: 
\code{\link{FitModelMI}()},
\code{\link{FitModelML}()}
}
\author{
Ivan Jacob Agaloos Pesigan
}
\concept{Model Fitting Functions}
\keyword{fit}
\keyword{manMCMedMiss}
\keyword{mediation}
\keyword{ml}
