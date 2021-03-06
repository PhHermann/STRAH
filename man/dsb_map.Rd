% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dsb_map.R
\docType{data}
\name{dsb_map}
\alias{dsb_map}
\title{Data of the DsbMap for humans}
\format{The data set contains 37527 rows and 27 columns. We provide information on the most important columns (column nr, column name) hereafter:
\describe{
\item{1, chrom}{The chromosome under study}
\item{2, start}{Start coordinates of the hotspot}
\item{3, end}{End coordinates of the hotspot}
\item{4-8, (AA1,AA2,AB1,AB2,AC)_strength}{Strength of the corresponding PRDM9-type hotspot. }
\item{9-15, (AA1,AA2,AB1,AB2,AC)_hotspots}{Dummy coding whether these positions (start/end) define a hotspot of given PRDM9-type}
}}
\usage{
data (dsb_map)
}
\description{
A dataset containing the PRDM9-A type hotspots of Pratto et al. 2014.
}
\references{
Heissl, A., et al. (2019) The impact of poly-A microsatellite heterologies in meiotic recombination. Life Science Alliance, 2(2) e20190036, doi: https://doi.org/10.26508/lsa.201900364

Pratto, F., et al. (2014). Recombination initiation maps of individual human genomes. Science, 346(6211).
}
\seealso{
\code{\link{STR_analysis}}, \code{\link{STR_detection}}
}
\keyword{datasets}
