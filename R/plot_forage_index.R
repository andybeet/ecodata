#' plot forage index
#'
#' Description should be here. This needs to be reworked to uncouple GB and GOM
#'
#' @param EPUs Character string. Which SOE report ("GB","MAB")
#' @param shadedRegion Numeric vector. Years denoting the shaded region of the plot
#' @param shade.fill Character string. Color of shaded region. (Default = "lightgrey)
#' @param shade.alpha Numeric scalar. Alpha of shaded region (Default = 0.5)
#'
#' @return ggplot object
#'
#'
#' @export
#'

plot_forage_index <- function(EPUs="MAB",
                              shadedRegion=c(2012,2022),
                              shade.fill="lightgrey",
                              shade.alpha=0.3) {


  x.shade.min <- shadedRegion[1]
  x.shade.max <- shadedRegion[2]

  if (EPUs == "GB") {
    filterEPUs <- c("GOM", "GB")
  } else {
    filterEPUs <- EPUs
  }


  fix<- ecodata::forage_index %>%
    dplyr::filter(Var %in% c("Fall Forage Fish Biomass Estimate",
                             "Spring Forage Fish Biomass Estimate"),
                  EPU %in% filterEPUs) %>%
    dplyr::group_by(EPU) %>%
    dplyr::summarise(max = max(Value))

  p <- ecodata::forage_index %>%
    dplyr::filter(Var %in% c("Fall Forage Fish Biomass Estimate",
                             "Fall Forage Fish Biomass Estimate SE",
                             "Spring Forage Fish Biomass Estimate",
                             "Spring Forage Fish Biomass Estimate SE"),
                  EPU %in% filterEPUs) %>%
    dplyr::group_by(EPU) %>%
    tidyr::separate(Var, into = c("Season", "A", "B", "C", "D", "Var")) %>%
    dplyr::mutate(Var = tidyr::replace_na(Var, "Mean")) %>% #,
                  #max = as.numeric(Value)) %>%
    tidyr::pivot_wider(names_from = Var, values_from = Value) %>%
    dplyr::left_join(fix) %>%
    dplyr::mutate(#Value = Value/resca,
      Mean = as.numeric(Mean),
      #max = as.numeric(Value),
      Mean = Mean/max,
      SE = SE/max,
      Upper = Mean + SE,
      Lower = Mean - SE) %>%
    ggplot2::ggplot(aes(x = Time, y = Mean, group = Season))+
    ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
        xmin = x.shade.min , xmax = x.shade.max,
        ymin = -Inf, ymax = Inf) +
    ggplot2::geom_ribbon(aes(ymin = Lower, ymax = Upper, fill = Season), alpha = 0.5)+
    ggplot2::geom_point()+
    ggplot2::geom_line()+
    ggplot2::ggtitle("")+
    ggplot2::ylab(expression("Relative forage biomass"))+
    ggplot2::xlab(element_blank())+
    ggplot2::facet_wrap(.~EPU)+
    ecodata::geom_gls()+
    ecodata::theme_ts()+
    ecodata::theme_facet()+
    ecodata::theme_title()

    if (EPUs == "GB") {
      p <- p +
        ggplot2::theme(legend.position = "bottom",
                       legend.title = element_blank())

    }

    return(p)

  # ecodata::forage_index %>%
  #   dplyr::filter(Var %in% c("Fall Forage Fish Biomass Estimate",
  #                            "Fall Forage Fish Biomass Estimate SE",
  #                            "Spring Forage Fish Biomass Estimate",
  #                            "Spring Forage Fish Biomass Estimate SE"),
  #                 EPU == "MAB") %>%
  #   tidyr::separate(Var, into = c("Season", "A", "B", "C", "D", "Var")) %>%
  #   dplyr::mutate(Var = replace_na(Var, "Mean"),
  #                 max = as.numeric(resca)) %>%
  #   tidyr::pivot_wider(names_from = Var, values_from = Value) %>%
  #   dplyr::mutate(#Value = Value/resca,
  #     Mean = as.numeric(Mean),
  #     Mean = Mean/max,
  #     SE = SE/max,
  #     Upper = Mean + SE,
  #     Lower = Mean - SE) %>%
  #   ggplot2::ggplot(aes(x = Time, y = Mean, group = Season))+
  #   ggplot2::annotate("rect", fill = shade.fill, alpha = shade.alpha,
  #                     xmin = x.shade.min , xmax = x.shade.max,
  #                     ymin = -Inf, ymax = Inf) +
  #   ggplot2::geom_ribbon(aes(ymin = Lower, ymax = Upper, fill = Season), alpha = 0.5)+
  #   ggplot2::geom_point()+
  #   ggplot2::geom_line()+
  #   ggplot2::ggtitle("Forage Biomass Index")+
  #   ggplot2::ylab(expression("Relative forage biomass"))+
  #   ggplot2::xlab(element_blank())+
  #   ecodata::geom_gls()+
  #   ecodata::theme_ts()+
  #   ecodata::theme_title()
  #
  #

}
