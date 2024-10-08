% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/forestplot.R
\name{forestplot}
\alias{forestplot}
\title{forestplot function}
\usage{
forestplot(
  df,
  name = name,
  estimate = estimate,
  se = se,
  pvalue = NULL,
  colour = NULL,
  shape = NULL,
  logodds = FALSE,
  psignif = 0.05,
  ci = 0.95,
  ...
)
}
\arguments{
\item{df}{A data frame with the data to plot. It must contain at least three
variables, a character column with the names to be displayed on the y-axis
(see parameter \code{name}), a numeric column with the value (or the log of the
value) to display (see parameter \code{estimate}) and a numeric value with
the corresponding standard errors (see parameter \code{se}). It may contain
additional columns, e.g. the corresponding p-values (see parameter \code{pvalue})
in which case, in conjuction with the threshold given in \code{psignif}, the
non-significant results will be displayed as hollow points. Other variables
may be used as ggplot2::aesthetics to define the colour and the shape of the points
to be plotted.}

\item{name}{the variable in \code{df} that contains the y-axis
names. This argument is automatically \link[rlang:quotation]{quoted} and
\link[rlang:eval_tidy]{evaluated} in the context of the \code{df} data frame.
See Note.}

\item{estimate}{the variable in \code{df} that contains the values (or log of
values) to be displayed. This argument is automatically
\link[rlang:quotation]{quoted} and \link[rlang:eval_tidy]{evaluated} in the
context of the \code{df} data frame.
See Note.}

\item{se}{the variable in the \code{df} data frame that contains the standard
error values. This argument is automatically \link[rlang:quotation]{quoted}
and \link[rlang:eval_tidy]{evaluated} in the context of the \code{df} data
frame. See Note.}

\item{pvalue}{the variable in \code{df} that contains the
p-values. Defaults to NULL. When explicitly defined, in conjuction with
the p-value threshold provided in the \code{psignif}, the non-significant
entries will be drawn as hollow points. This argument is automatically
\link[rlang:quotation]{quoted} and \link[rlang:eval_tidy]{evaluated} in the
context of the \code{df} data frame. See Note.}

\item{colour}{the variable in \code{df} by which to colour the different
groups of points. This argument is automatically \link[rlang:quotation]{quoted} and
\link[rlang:eval_tidy]{evaluated} in the context of the \code{df} data frame.
See Note.}

\item{shape}{the variable in \code{df} by which to shape the different groups of
points. This argument is automatically \link[rlang:quotation]{quoted} and
\link[rlang:eval_tidy]{evaluated} in the context of the \code{df} data frame.
See Note.}

\item{logodds}{logical (defaults to FALSE) specifying whether the \code{estimate}
parameter should be treated as log odds/hazards ratio (TRUE) or not (FALSE). When
\code{logodds} = TRUE the estimates and corresponding confidence intervals will be
exponentiated and a log scale will be used for the x-axis.}

\item{psignif}{numeric, defaults to 0.05. The p-value threshold
for statistical significance. Entries with larger than \code{psignif} will be
drawn with a hollow point.}

\item{ci}{A number between 0 and 1 (defaults to 0.95) indicating the type of
confidence interval to be drawn.}

\item{...}{\code{ggplot2} graphical parameters such as \code{title},
\code{ylab}, \code{xlab}, \code{xtickbreaks} etc. to be passed along.}
}
\value{
A \code{ggplot} object.
}
\description{
forestplot function
}
\note{
See \code{vignette(programming, package = "dplyr")} for an
introduction to non-standard evaluation.
}
\author{
Maria Kalimeri, Ilari Scheinin, Vilma Jagerroos
}
