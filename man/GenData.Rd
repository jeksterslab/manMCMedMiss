% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manMCMedMiss-gen-data.R
\name{GenData}
\alias{GenData}
\title{Generate Data}
\usage{
GenData(n = 100L, tauprime = 0, beta = 0.5, alpha = 0.5, mu = 0, sigmasq = 1)
}
\arguments{
\item{n}{Positive integer.
Sample size.}

\item{tauprime}{Numeric.
\eqn{\tau^{\prime}}, that is,
the slope for \eqn{Y} regressed on \eqn{X}, adjusting for \eqn{M}.}

\item{beta}{Numeric.
\eqn{\beta}, that is,
the slope for \eqn{Y} regressed on \eqn{M}, adjusting for \eqn{X}.}

\item{alpha}{Numeric vector.
Significance level.}

\item{mu}{Numeric.
Common mean for \eqn{X}, \eqn{M}, and \eqn{Y},
that is, \eqn{\mu_{X} = \mu_{M} = \mu_{Y}}.}

\item{sigmasq}{Numeric.
Common variance for \eqn{X}, \eqn{M}, and \eqn{Y},
that is, \eqn{\sigma^{2}_{X} = \sigma^{2}_{M} = \sigma^{2}_{Y}}.}
}
\value{
Returns a matrix.
}
\description{
Let the simple mediation model be defined by
the equations
\deqn{Y = \delta_{Y} + \tau^{\prime} X + \beta M + \varepsilon_{Y},}
and
\deqn{M = \delta_{M} + \alpha X + \varepsilon_{M}.}
The function generates data from the multivariate normal distribution
using the model-implied mean vector and covariance matrix
of the simple mediation model.
See \code{MASS::mvrnorm()} for more details.
}
\references{
MacKinnon, D. P. (2008).
\emph{Introduction to statistical mediation analysis}.
Lawrence Erlbaum Associates.
}
\seealso{
Other Data Generation Functions: 
\code{\link{AmputeData}()},
\code{\link{ImputeData}()}
}
\author{
Ivan Jacob Agaloos Pesigan
}
\concept{Data Generation Functions}
\keyword{gendata}
\keyword{manMCMedMiss}
\keyword{mediation}
\keyword{normal}
