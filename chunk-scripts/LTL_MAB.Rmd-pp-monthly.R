
out_pp <- ecodata::chl_pp %>% 
  dplyr::filter(EPU == epu_abbr,
         stringr::str_detect(Var, "MONTHLY_PPD_MEDIAN")) %>% 
  tidyr::separate(.,Time, into = c("Cat", "Time2"), sep = "_") %>% 
  tidyr::separate(.,Time2, into = c("Year", "Month"), sep = 4) %>% 
  dplyr::mutate(Month = plyr::mapvalues(Month, from = c("01","02","03","04","05","06",
                                                   "07","08","09","10","11","12"),
                                   to = c(month.abb))) %>% 
  dplyr::filter(!Value == "NA") %>% 
  dplyr::group_by(Month) %>% 
  dplyr::mutate(hline = mean(Value))

out_pp$Month <- factor(out_pp$Month, levels = month.abb)


pp_cci <- ggplot2::ggplot(out_pp) +
    #ecodata::geom_lm(aes(x = Year, y = Value, group = Month))+
    ggplot2::geom_point(aes(x = Year, y = Value, group = Month)) +
    ggplot2::geom_line(aes(x = Year, y = Value, group = Month)) +
    ggplot2::scale_x_discrete(name = "", breaks = seq(min(out_pp$Year),max(out_pp$Year),10)) +  
    ggplot2::geom_hline(aes(yintercept = hline),
           size = hline.size,
           alpha = hline.alpha,
           linetype = hline.lty) +
    ggplot2::facet_wrap(Month~., ncol = 12) +
    ggplot2::ggtitle("Monthly median PPD") +
    ggplot2::ylab(expression("PP (gC m"^-2*" d"^-1*")")) +
    ecodata::theme_facet() +
    ggplot2::ylab("Time")+
    ggplot2::theme(axis.text.x = element_text(angle=45, hjust = 1),
          panel.spacing = unit(0.5, "lines"),
          plot.margin = unit(c(0.1, 0, 0, 0), "cm"))+
  ecodata::theme_title()
pp_cci
