% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manMCMedMiss-tree.R
\name{Tree}
\alias{Tree}
\title{Conditional Inference Tree}
\usage{
Tree(results, type, alpha = 1e-04, maxdepth = 0, dichotomize = TRUE)
}
\arguments{
\item{results}{Data frame.
The package data frame \code{results()}.}

\item{type}{Character string.
Type of results to plot.
Valid values are \code{"type1"}, \code{"power"}, and \code{"miss"}
for Type I error rate, statistical power, and miss rate, respectively.}

\item{alpha}{Significance level used for splitting.}

\item{maxdepth}{maximum depth of the tree.
The default \code{maxdepth = 0}
means that no restrictions are applied to tree sizes.}

\item{dichotomize}{Logical.
Dichotomize the outcome variable into \code{robust = TRUE} and \code{robust = FALSE}.}
}
\value{
Returns the result of \code{party::ctree()}.
}
\description{
Conditional Inference Tree
}
\author{
Ivan Jacob Agaloos Pesigan
}
\concept{Conditional Inference Tree Functions}
\keyword{manMCMedMiss}
\keyword{tree}
