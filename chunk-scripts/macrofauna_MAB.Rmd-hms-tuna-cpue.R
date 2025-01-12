
ecodata::hms_cpue %>% 
  filter(stringr::str_detect(Var, "TUNA")) %>% 
  ggplot()+
 ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ggplot2::geom_point(aes(x=Time, y = Value))+
  ggplot2::geom_line(aes(x=Time, y = Value))+
  ggplot2::facet_wrap(~Var, scales = "free")+
  ggplot2::ggtitle("HMS POP TUNA CPUE")+
  ggplot2::ylab("Number per Haul")+
  ggplot2::xlab(element_blank())+
  ecodata::geom_gls(aes(x=Time, y = Value))+
  ecodata::theme_ts()+
  ecodata::theme_title()
