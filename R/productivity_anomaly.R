#' Small fish per large fish biomass anomaly
#'
#' These data represent estimates of recruitment success for species sampled
#' in the NEFSC Bottom Trawl Survey and those calculated for stock assessments.
#'
#' @format Data frame with 8241 rows and 5 columns.
#'
#' \itemize{
#'    \item Var: Common name of surveyed species. If data reflect the aggregated shelf-wide anomaly, then \code{NE LME} is included with the species name.
#'    \item EPU: EPU where sampling occurred.
#'    \item Time: Year.
#'    \item Value: Small fish per large fish biomass anomaly.
#'    \item Units: Units of variable \code{Var}.
#' }
#'
#' @details Detailed information regarding the derivation of this indicator are present at
#' \url{https://noaa-edab.github.io/tech-doc/fish-productivity-indicator.html}.
#'
#' @references
#' Perretti, Charles T., et al. "Regime shifts in fish recruitment on the Northeast US Continental Shelf." \emph{Marine Ecology Progress Series} 574 (2017): 1-11.
#'
#' Wigley, S. E., H. M. McBride, and N. J. McHugh. 2003. “Length-Weight Relationships for 74 Fish Species Collected During NEFSC Research Vessel Bottom Trawl Surveys, 1992-99.” NOAA Technical Memorandum 171. National Marine Fisheries Service.
"productivity_anomaly"
