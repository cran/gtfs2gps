% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simplify_shapes.R
\name{simplify_shapes}
\alias{simplify_shapes}
\title{Simplify shapes of a GTFS file}
\usage{
simplify_shapes(gtfs_data, tol = 0)
}
\arguments{
\item{gtfs_data}{A list of data.tables read using gtfs2gps::read_gtfs().}

\item{tol}{Numerical tolerance value to be used by the Douglas-Peucker algorithm.
The default value is 0, which means that no data will be lost.}
}
\value{
A GTFS data whose shapes is a subset of the input data.
}
\description{
Remove points from the shapes of a GTFS file in order to
reduce its size. It uses Douglas-Peucker algorithm internally.
}
