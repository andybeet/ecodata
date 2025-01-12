# Process North Atlantic Oscillation time series
# Data grabbed from here https://climatedataguide.ucar.edu/climate-data/hurrell-north-atlantic-oscillation-nao-index-station-based
# Download Data DJFM Station

library(dplyr)

#Get raw
raw.dir <- here::here("data-raw") #input raw


get_nao <- function(save_clean = F){

  nao <- read.csv(file.path(raw.dir, "NAO_index.csv")) %>%
    dplyr::mutate(Var = "north atlantic oscillation",
           Units = "unitless",
           EPU = "All") %>%
    as.data.frame()%>%
    tibble::as_tibble() %>%
    dplyr::select(Time, Var, Value, EPU, Units)

  if (save_clean){
    usethis::use_data(nao, overwrite = T)
  } else {
    return(nao)
  }
}
get_nao(save_clean = T)
