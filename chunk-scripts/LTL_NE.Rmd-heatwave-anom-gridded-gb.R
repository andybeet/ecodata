
#EPU shapefile
ne_epu_sf <- ecodata::epu_sf %>% 
  dplyr::filter(EPU %in% c("GOM","GB"))

#Map line parameters
map.lwd <- 0.4

# Set lat/lon window for maps
xmin = -73
xmax = -65
ymin = 39
ymax = 45
xlims <- c(xmin, xmax)
ylims <- c(ymin, ymax)
hw <- ecodata::heatwave_peak_date %>% 
  dplyr::filter(EPU == "GB")# %>% 
  #dplyr::mutate(Value = replace(Value, Value > 4, 4))

gb_map <- 
  ggplot2::ggplot() +
  ggplot2::geom_tile(data =hw, aes(x = Longitude, y = Latitude,fill = Value)) +
  ggplot2::geom_sf(data = ecodata::coast, size = map.lwd) +
  ggplot2::geom_sf(data = ne_epu_sf, fill = "transparent", size = map.lwd) +
  ggplot2::scale_fill_gradientn(name = "Temp.\nAnomaly (C)", 
                                colours = c(scales::muted("blue"), "white",
                                            scales::muted("red"), "black"),
                                values = scales::rescale(c(-4,0,4,8)),
                                guide = "colorbar", limits=c(-4,8)) +
  ggplot2::coord_sf(crs = crs, xlim = xlims, ylim = ylims) +
  #facet_wrap(Season~.) +
  ecodata::theme_map() +
  ggplot2::ggtitle("GB heatwave anomaly (Aug 14, 2020)") +
  ggplot2::xlab("Longitude") +
  ggplot2::ylab("Latitude") +
  ggplot2::theme(panel.border = element_rect(colour = "black", fill=NA, size=0.75),
        legend.key = element_blank(),
        axis.title = element_text(size = 11),
        strip.background = element_blank(),
        strip.text=element_text(hjust=0),
        axis.text = element_text(size = 8))+
  ecodata::theme_title()


gb_map 
