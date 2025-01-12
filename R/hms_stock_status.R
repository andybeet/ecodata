#' Highly Migratory species stock status
#'
#' Stock status for highly migratory species in North Atlantic.
#'
#' @format 48 rows and 4 columns
#'
#' \itemize{
#'     \item Time: Year
#'     \item Var: Either \code{F.Fmsy}, representing the ratio of fishery mortality to fishery mortality
#'     at maximum sustainable yield (or proxy), or \code{B.Bmsy}, defined as the ratio of estimated stock biomass to
#'     estimated biomass at maximum sustainable yield (or proxy).
#'     \item Value: Value of variable \code{Var}.
#'     \item EPU: Ecological Production Unit (EPU) where sampling occurred.
#' }
#'
#' @details
#' More information about this data set may be found at \url{https://noaa-edab.github.io/tech-doc/atlantic-highly-migratory-species-stock-status.html}.
#'
"hms_stock_status"
