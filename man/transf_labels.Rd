% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transf_variables.R
\name{transf_labels}
\alias{transf_labels}
\title{Create columns headings for after the transformation.}
\usage{
transf_labels(
  comp_labels,
  transformation_type,
  comparison_part = NULL,
  part_1 = NULL
)
}
\arguments{
\item{comp_labels}{The labels of the compositional columns.}

\item{transformation_type}{The type of transformation desired. Should be \code{"ilr", "alr"} or \code{"clr"}.}

\item{comparison_part}{Only needed for alr transformation. Should be an element of \code{comp_labels}. Name of part that all other parts will be compared to.}

\item{part_1}{Only used if first part in ilr-pivot coordinate transformation. Passed to \code{alter_order_comp_labels} unless \code{NULL}.}
}
\description{
Create columns headings for after the transformation.
}
