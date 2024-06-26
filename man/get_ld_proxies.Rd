% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gwasvcf_functions.R
\name{get_ld_proxies}
\alias{get_ld_proxies}
\title{Find LD proxies for a set of SNPs}
\usage{
get_ld_proxies(
  rsid,
  bfile,
  searchspace = NULL,
  tag_kb = 5000,
  tag_nsnp = 5000,
  tag_r2 = 0.6,
  threads = 1,
  out = tempfile()
)
}
\arguments{
\item{rsid}{list of rs IDs}

\item{bfile}{ld reference panel}

\item{searchspace}{Optional list of rs IDs to use as potential proxies}

\item{tag_kb}{=5000 Proxy parameter}

\item{tag_nsnp}{=5000 Proxy parameter}

\item{tag_r2}{=0.6 Proxy parameter}

\item{threads}{Number of threads to use (=1)}

\item{out}{temporary output file}
}
\value{
data frame
}
\description{
Find LD proxies for a set of SNPs
}
