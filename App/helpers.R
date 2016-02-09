# este script contiene el codigo que haria server.R voluminoso

### Graficado

#stilo
estilo <- theme(plot.title = element_text(family = "Trebuchet MS", color = "#666666", face = "bold", size = 25)) +
          theme(axis.title = element_text(family = "Trebuchet MS", color = "#666666", face = "bold", size = 20)) +
          theme(axis.text.x = element_text(family = "Trebuchet MS", size = 15, colour = "gray20"))

# ejes 
eje_y_global_stack <- scale_y_continuous(breaks = seq(from = 6e5, to = 8e5, by = 5e4), limits = c(5.9e5, 8e5),
                                         labels = c("600", "650", "700", "750", "800"))
eje_y_proporcional <- scale_y_continuous(breaks = seq(from = 0, to = 1, by = 0.1), expand = c(0,0))

eje_y_individual <- scale_y_discrete(breaks = seq(from = 0, to = 5e5, by = 1e5),
                                     labels = as.character(seq(from = 0, to = 500, by = 100)))

eje_x_global <- scale_x_continuous(breaks = seq(1990, 2010, by = 5), expand = c(0, 1),
                                   minor_breaks = seq(1990, 2010, 1)) 
eje_x_proporcional <- scale_x_continuous(breaks = seq(1990, 2010, by = 5),
                                         minor_breaks = seq(1990, 2010, 1), expand = c(0,0))

## Geometric objects 

plot_dispersion <- geom_point(size = 3, colour = "steelblue4")

# agrupados
plot_area <- geom_area(alpha = 0.85)
plot_proporcion <-  geom_area(size = 1, position = "fill", aes(ymax = 1), alpha = 0.8)

# individuales
plot_linea <- geom_line(size = 1)

## Guias para la lectura

# guia categoria I
etiquetas_componentes <- c("Agricultura", "Aviación y \n navegación \n internacional", "Desechos",
                           "Quema de biomasa", "Energía", "Procesos industriales",
                           "Uso de suelo, cambio \n de uso de suelo,\n silvicultura")
guia_I_agrupados <- scale_fill_brewer(palette = "Accent", name = "Categoría",
                                      labels = etiquetas_componentes)
    
guia_I_linea <- scale_color_brewer(palette = "Accent", name = "Categoria",
                                   labels = etiquetas_componentes)

# guia gases
guia_gases <- scale_fill_brewer(palette = "Dark2", name = "Gas",
                  labels = c("CO2", "CH4", "N2O", "HCF's", "CF4", "C2F6", "SF6"))

