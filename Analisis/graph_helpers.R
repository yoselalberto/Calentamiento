## elementos gráficos

# estilo
estilo <- theme(plot.title = element_text("Trebuchet MS", "bold", "#666666", size = 30)) +
            theme(axis.title = element_text("Trebuchet MS", "bold","#666666", size = 20)) +
            theme(axis.text.x = element_text("Trebuchet MS", size = 15, colour = "gray20"))

# eje
eje_y_global_stack <- scale_y_continuous(breaks = seq(from = 6e5, to = 8e5, by = 5e4), limits = c(5.9e5, 8e5),
                                         labels = c("600", "650", "700", "750", "800"))
eje_y_proporcional <- scale_y_continuous(breaks = seq(from = 0, to = 1, by = 0.1), expand = c(0,0))

eje_y_individual <- scale_y_discrete(breaks = seq(from = 0, to = 5e5, by = 1e5),
                                     labels = as.character(seq(from = 0, to = 500, by = 100)))

eje_x_global <- scale_x_continuous(breaks = seq(1990, 2010, by = 5), expand = c(0, 0.5),
                                   minor_breaks = seq(1990, 2010, 1)) 
eje_x_proporcional <- scale_x_continuous(breaks = seq(1990, 2010, by = 5),
                                         minor_breaks = seq(1990, 2010, 1), expand = c(0,0))
    
# guías
etiquetas_I <- c("Agricultura", "Aviación y \nnavegación \ninternacional", "Desechos",
                           "Quema de biomasa", "Energía", "Procesos industriales",
                           "Uso de suelo, cambio\nde uso de suelo,\nsilvicultura")

etiquetas_gas <- c("CO2", "CH4", "N2O", "HCF's", "CF4", "C2F6", "SF6")