% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mr_functions.R
\name{harmonise_12}
\alias{harmonise_12}
\title{Harmonises alleles for a 1-2 allele configuration.}
\usage{
harmonise_12(SNP, A1, B1, B2, betaA, betaB, fA, fB, tolerance, action)
}
\arguments{
\item{SNP}{Vector of SNP IDs.}

\item{A1}{First allele for exposure.}

\item{B1}{First allele for outcome.}

\item{B2}{Second allele for outcome.}

\item{betaA}{Effect sizes for exposure.}

\item{betaB}{Effect sizes for outcome.}

\item{fA}{Allele frequencies for exposure.}

\item{fB}{Allele frequencies for outcome.}

\item{tolerance}{Tolerance for allele frequency matching.}

\item{action}{Action to take for ambiguous or incompatible alleles.}
}
\value{
A data frame with harmonised alleles.
}
\description{
This function harmonises alleles for a 1-2 allele configuration by flipping and recoding indels.
}
