
council_abbr <- "NEFMC"
#Managed landings
managed_landings <- ecodata::comdat  %>%
  dplyr::filter(Var %in% c("Planktivore NEFMC managed species - Seafood Landings",
                           "Piscivore NEFMC managed species - Seafood Landings",
                           "Benthivore NEFMC managed species - Seafood Landings",
                           "Apex Predator NEFMC managed species - Seafood Landings",
                           "Benthos NEFMC managed species - Seafood Landings", "Planktivore JOINT managed species - Seafood Landings",
                           "Piscivore JOINT managed species - Seafood Landings",
                           "Benthivore JOINT managed species - Seafood Landings",
                           "Apex Predator JOINT managed species - Seafood Landings",
                           "Benthos JOINT managed species - Seafood Landings"),
         Time >= 1986) 

US_landings <- ecodata::comdat  %>%
  dplyr::filter(Var == "Seafood Landings",
         Time >= 1986)
# #Total landings
total_landings <- ecodata::comdat  %>%
  dplyr::filter(Var == "Landings",
         Time >= 1986)

total_landings_agg <- total_landings %>%
  dplyr::group_by(EPU,Time) %>%
  dplyr::summarise(Value = sum(Value)/1000) %>% 
  dplyr::mutate(Var = "Total",hline = mean(Value))

us_total_landings_agg <- US_landings %>%
  dplyr::group_by(EPU,Time) %>%
  dplyr::summarise(Value = sum(Value)/1000) %>% 
  dplyr::mutate(Var = "USTotal",hline = mean(Value))

managed_landings_agg <- managed_landings %>%
  dplyr::group_by(EPU,Time) %>%
  dplyr::summarise(Value = sum(Value)/1000) %>% 
  dplyr::mutate(Var = "Managed",hline = mean(Value))

landings_agg <- rbind(total_landings_agg, managed_landings_agg, us_total_landings_agg)# %>% 
#  dplyr::mutate(Value = Value/1000)
series.col2 <- c("indianred",  "black", "steelblue4")
  
landings_agg_pre2018<- landings_agg %>% 
  dplyr::filter(Time <=2018, 
                EPU == "GOM", 
                Var == "Total")

landings_agg_post2018<- landings_agg %>% 
  dplyr::filter(Time >2018, 
                EPU == "GOM", 
                Var == "Total")
landings_aggx<- landings_agg %>% 
  dplyr::filter(EPU == "GOM", 
                !Var == "Total")

gom_total <- landings_aggx %>% 
ggplot2::ggplot()+
  
  #Highlight last ten years
  ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ecodata::geom_gls(aes(x = Time, y = Value,
               group = Var),
             alpha = trend.alpha, size = trend.size) +
  #ecodata::geom_lm(aes(x = Time, y = Value))+
  ggplot2::geom_line(aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(aes(x = Time, y = Value, color = Var), size = pcex) +
  ggplot2::ylim(0,190)+
  ggplot2::geom_line(data =landings_agg_post2018, aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(data =landings_agg_post2018,aes(x = Time, y = Value, color = Var), size = pcex, shape = 1)+
  ggplot2::geom_line(data =landings_agg_pre2018, aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(data =landings_agg_pre2018,aes(x = Time, y = Value, color = Var), size = pcex, shape = 16)+

#  ggplot2::scale_y_continuous(labels = function(l){trans = l / 1000})+
  ggplot2::scale_x_continuous(breaks = seq(1985, 2020, by = 5), expand = c(0.01, 0.01)) +
  ggplot2::scale_color_manual(values = series.col2, aesthetics = "color")+
  ggplot2::guides(color = FALSE) +
  ggplot2::ylab(expression("Landings (10"^3*"mt)")) +
  ggplot2::xlab(element_blank())+
  ggplot2::theme(legend.position = "left")+
  ggplot2::geom_hline(aes(yintercept = hline,
               
               color = Var),
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty) +
  ecodata::theme_ts() +
  ggplot2::ggtitle("Gulf of Maine")+
  ecodata::theme_title()

landings_agg_pre2018<- landings_agg %>% 
  dplyr::filter(Time <=2018, 
                EPU == "GB", 
                Var == "Total")

landings_agg_post2018<- landings_agg %>% 
  dplyr::filter(Time >2018, 
                EPU == "GB", 
                Var == "Total")
landings_aggx<- landings_agg %>% 
  dplyr::filter(EPU == "GB", 
                !Var == "Total")

gb_total <- landings_aggx %>% 
ggplot2::ggplot()+
  
  #Highlight last ten years
  ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ecodata::geom_gls(aes(x = Time, y = Value,
               group = Var),
             alpha = trend.alpha, size = trend.size) +
  
  #ecodata::geom_lm(aes(x = Time, y = Value, group = Var))+
  ggplot2::geom_line(aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(aes(x = Time, y = Value, color = Var), size = pcex) +
  ggplot2::ylim(0,190)+
  ggplot2::geom_line(data =landings_agg_post2018, aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(data =landings_agg_post2018,aes(x = Time, y = Value, color = Var), size = pcex, shape = 1)+
  ggplot2::geom_line(data =landings_agg_pre2018, aes(x = Time, y = Value, color = Var), size = lwd) +
  ggplot2::geom_point(data =landings_agg_pre2018,aes(x = Time, y = Value, color = Var), size = pcex, shape = 16)+
#  ggplot2::scale_y_continuous(labels = function(l){trans = l / 1000})+
  ggplot2::scale_x_continuous(breaks = seq(1985, 2020, by = 5), expand = c(0.01, 0.01)) +
  ggplot2::scale_color_manual(values = series.col2, aesthetics = "color")+
  ggplot2::guides(color = FALSE) +
  ggplot2::ylab(expression("Landings (10"^3*"mt)")) +
  ggplot2::xlab(element_blank())+
  ggplot2::geom_hline(aes(yintercept = hline,
               
               color = Var),
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty) +
  ecodata::theme_ts() +
  ggplot2::ggtitle("Georges Bank")+
  ecodata::theme_title()

plot_row<-cowplot::plot_grid( gb_total, gom_total, ncol = 2)
title <- ggdraw() + 
  draw_label(
    "Total Commercial Landings",
    x = 0,
    hjust = 0
  ) +
  theme(
    # add margin on the left of the drawing canvas,
    # so title is aligned with left edge of first plot
    plot.margin = margin(0, 0, 0,1)
  )


cowplot::plot_grid(title, plot_row, ncol = 1, 
                   rel_heights = c(0.1, 1))
