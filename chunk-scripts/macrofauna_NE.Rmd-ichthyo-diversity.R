
gom_larv_div <- ecodata::ichthyo_diversity %>%
  dplyr::filter(EPU == "GOM") %>%
  #dplyr::mutate(Var = word(Var,1)) %>% 
  #dplyr::group_by(Var) %>% 
  dplyr::mutate(hline = mean(Value, na.rm = T)) %>% 
  ggplot2::ggplot(aes(x = Time, y = Value, group = Var)) +
  ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ecodata::geom_gls(aes(x = Time, y = mean(Value))) +
  #ecodata::geom_lm(aes(x=Time, y = Value))+
  ggplot2::ggtitle("GOM larval diversity") +
  ggplot2::ylab("Shannon Diversity") +
  ggplot2::xlab(element_blank())+
  ggplot2::scale_x_continuous(expand = c(0.01, 0.01))+
  ggplot2::geom_hline(aes(yintercept = hline),
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty)+
  ecodata::theme_facet() +
  #ggplot2::ylim(0.35,NA)+
  ggplot2::theme(strip.text=element_text(hjust=0))+
  ecodata::theme_title()

gb_larv_div <- ecodata::ichthyo_diversity %>%
  dplyr::filter(EPU == "GB") %>%
  #dplyr::mutate(Var = word(Var,1)) %>% 
  #dplyr::group_by(Var) %>% 
  dplyr::mutate(hline = mean(Value, na.rm = T)) %>% 
  ggplot2::ggplot(aes(x = Time, y = Value, group = Var)) +
  ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ecodata::geom_gls(aes(x = Time, y = mean(Value))) +
  #ecodata::geom_lm(aes(x=Time, y = Value))+
  ggplot2::ggtitle("GB larval diversity") +
  ylab("Shannon Diversity") +
  ggplot2::xlab(element_blank())+
  ggplot2::scale_x_continuous(expand = c(0.01, 0.01))+
   geom_hline(aes(yintercept = hline),
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty)+
  #ggplot2::ylim(0.35,NA)+
  ecodata::theme_facet() +
  ggplot2::theme(strip.text=element_text(hjust=0))+
  ecodata::theme_title()

gb_larv_div + gom_larv_div + patchwork::plot_layout(ncol = 1)
