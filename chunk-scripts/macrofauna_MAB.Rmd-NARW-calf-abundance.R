
ecodata::narw %>% 
  dplyr::filter(Var == "Calves") %>%
  dplyr::mutate(Value = as.numeric(Value), 
                Time = as.numeric(Time),
                hline = mean(Value, na.rm = T)) %>% 
  ggplot2::ggplot() +
#Highlight last ten years
  ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
      xmin = x.shade.min , xmax = x.shade.max,
      ymin = -Inf, ymax = Inf) +
  ggplot2::geom_line(aes(x = Time, y = Value), size = lwd-0.75) +
  ggplot2::geom_point(aes(x = Time, y = Value), size = pcex-0.75) +
  #ecodata::geom_lm(aes(x = Time, y = Value))+
  ggplot2::scale_x_continuous(expand = c(0.01, 0.01)) +
  ggplot2::guides(color = FALSE) +
  ggplot2::ggtitle("NARW calf abundance") +
  ggplot2::ylab(expression("Abundance (n)")) +
  ggplot2::xlab(element_blank())+
  ggplot2::geom_hline(aes(yintercept = hline),
           color = "black",
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty) +
  ecodata::theme_ts()+
  ecodata::theme_title()
