% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mr_functions.R
\name{check_required_columns}
\alias{check_required_columns}
\title{Checks required columns in the input data frame.}
\usage{
check_required_columns(dat, type = "exposure")
}
\arguments{
\item{dat}{Data frame to check.}

\item{type}{Type of data (exposure or outcome).}
}
\value{
NULL if all required columns are present.
}
\description{
This function checks if the required columns are present in the input data frame.
}
