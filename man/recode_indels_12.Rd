% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mr_functions.R
\name{recode_indels_12}
\alias{recode_indels_12}
\title{Recodes indels for 1-2 allele configuration.}
\usage{
recode_indels_12(A1, B1, B2)
}
\arguments{
\item{A1}{First allele for exposure.}

\item{B1}{First allele for outcome.}

\item{B2}{Second allele for outcome.}
}
\value{
A data frame with recoded alleles.
}
\description{
This function recodes insertions and deletions (indels) for a 1-2 allele configuration.
}
