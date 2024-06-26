% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TwoSampleMR_functions.R
\name{replace_na_with_mean}
\alias{replace_na_with_mean}
\title{add the mean sample size for missing SNP sample sizes}
\usage{
replace_na_with_mean(data, grouping_column, column_name)
}
\arguments{
\item{data}{Data frame containing SNP data.}

\item{grouping_column}{Column to group by.}

\item{column_name}{Name of the column with missing values.}
}
\value{
Data frame with missing values replaced by mean.
}
\description{
add the mean sample size for missing SNP sample sizes
}
