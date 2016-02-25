## elementos gráficos

# estilo
estilo <- theme(plot.title = element_text("Trebuchet MS", "bold", "#666666", 30),
                axis.title = element_text("Trebuchet MS", "bold","#666666", 20),
                axis.text.x = element_text("Trebuchet MS", size = 15, colour = "gray15"))

# ejes
eje_y_glob <-  scale_y_continuous(breaks = seq(6e5, 8e5, by = 5e4),
                                  labels = c("600", "650", "700", "750", "800"))
eje_y_cat <-  scale_y_continuous(breaks = seq(0, 8e5, by = 1e5), expand = c(0.01, 0),
                    labels = as.character(seq(0, 800, by = 100)))

eje_y_global_stack <- scale_y_continuous(breaks = seq(6e5, 8e5, by = 5e4), 
                                         limits = c(5.9e5, 8e5), 
                                         labels = c("600", "650", "700", "750", "800"))
eje_y_proporcional <- scale_y_continuous(breaks = seq(0, 1, by = 0.1), expand = c(0,0))

eje_y_individual <- scale_y_discrete(breaks = seq(0, 5e5, by = 1e5),
                                     labels = as.character(seq(0, 500, by = 100)))
# eje x
eje_x_glob <- scale_x_continuous(breaks = seq(1990, 2010, by = 5), 
                                   expand = c(0, 0.5), minor_breaks = seq(1990, 2010, 1)) 
eje_x_proporcional <- scale_x_continuous(breaks = seq(1990, 2010, by = 5),
                                         minor_breaks = seq(1990, 2010, 1), expand = c(0,0))
    
# guías
etiquetas_I <- c("Agriculture", "International\ntransport", "Waste",
                 "Biomass\nburning", "Energy", "Industrial\nprocesess",
                 "Land use\nchange of use,\nsilviculture")

etiquetas_gas <- list(TeX('$CO_{2}$'), TeX('$CH_{4}$'), TeX('$N_{2}O$'), TeX("HCF's"), 
                      TeX('$CF_{4}$'), TeX('$C_{2}F_{6}$'), TeX('$SF_{6}$'))
