% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colorspace.R
\name{LAB}
\alias{LAB}
\title{Create LAB Colors}
\usage{
LAB(L, A, B, names)
}
\arguments{
\item{L, A, B}{these arguments give the L, A and B coordinates of the colors.
The values can be provided in separate \code{L}, \code{A} and \code{B}
vectors or in a three-column matrix passed as \code{L}.}

\item{names}{a vector of names for the colors (by default the row names of
\code{L} are used).}
}
\value{
An object of class \code{LAB} which inherits from class \code{color}.
}
\description{
This function creates colors of class ``LAB''; a subclass of the virtual
\code{\link{color-class}} class.
}
\details{
The \code{L}, \code{A} and \code{B} values give the coordinates of the
colors in the CIE \eqn{L^*a^*b^*}{L*a*b*} space.  This is a transformation
of the 1931 CIE XYZ space which attempts to produce perceptually based axes.
Luminance takes values between 0 and 100, and the other coordinates 
typically take values between -100 and 100, although these values can also
be exceeded by highly saturated colors. The \eqn{a} and \eqn{b} coordinates
measure positions on green/red and blue/yellow axes.
}
\examples{
## Show the LAB space
set.seed(1)
x <- sRGB(runif(1000), runif(1000), runif(1000))
y <- as(x, "LAB")
head(x)
head(y)
plot(y)
}
\seealso{
\code{\link{RGB}}, \code{\link{HSV}}, \code{\link{XYZ}},
\code{\link{LAB}}, \code{\link{polarLAB}}, \code{\link{LUV}},
\code{\link{polarLUV}}.
}
\author{
Ross Ihaka
}
\keyword{color}
