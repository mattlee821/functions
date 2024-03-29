% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/imputation_test.R
\name{imputation_test_package}
\alias{imputation_test_package}
\title{Perform Imputation Test}
\usage{
imputation_test_package(rmd_location, data, output_dir, subtitle)
}
\arguments{
\item{rmd_location}{Location of the Rmd file within the package.}

\item{data}{Data to be passed to the Rmd file.}

\item{output_dir}{Output directory for the rendered HTML file.}

\item{subtitle}{Subtitle to be used in the rendered HTML file.}
}
\value{
The result of the imputation test.
}
\description{
This function performs an imputation test using the specified qmd file.
Your data should have samples as rows and features as columns. There should
be no extra columns. This function is for testing.
}
\examples{
\dontrun{
imputation_test_package(rmd_location = "rmd/imputation_test.qmd",
                        data = mtcars,
                        output_dir = "project1/data/",
                        subtitle = "imputation testing for mtcars")
}

}
