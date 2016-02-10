# codigo de soporte para server.R 

### Graficado

# stilo
estilo <- theme(text = element_text("Trebuchet MS", "bold", "#666666"),
                plot.title  = element_text(size = 30),
                axis.title  = element_text(size = 20),
                axis.text.x = element_text(size = 15, colour = "gray15"))
 
## Marcas
# x
marcas_x     <- seq(1990, 2010, by = 5)
marquitas_x  <- seq(1990, 2010, 1)
# y
marcas_y_enc <- seq(0, 8e5, by = 1e5)
marcas_y_ind <- seq(0, 5e5, by = 1e5)

# eje y
eje_y_enc <- scale_y_continuous(breaks = marcas_y_enc,
                                labels = as.character(seq(0, 800, by = 100)))
eje_y_ind <- scale_y_discrete(breaks = marcas_y_ind, 
                              labels = c("0", "100", "200", "300", "400", "500"))
eje_y_prop <- scale_y_continuous(breaks = seq(0, 1, by = 0.1), expand = c(0, 0),
                                 minor_breaks = NULL)
# eje x
eje_x <- scale_x_continuous(breaks = marcas_x, expand = c(0, 0.2),
                                minor_breaks = marquitas_x) 
eje_x_prop <- scale_x_continuous(breaks = marcas_x, expand = c(0, 0),
                                 minor_breaks = marquitas_x)

## Geometric objects

# agrupados
plot_area <- geom_area(alpha = 0.85)
plot_proporcion <-  geom_area(size = 1, position = "fill", aes(ymax = 1, fill = categoria_1), alpha = 0.8)

## Guias
# categoria I
et_comp <- c("Agricultura", "Aviación y \n navegación \n internacional", "Desechos",
             "Quema de biomasa", "Energía", "Procesos industriales",
             "Uso de suelo, cambio \n de uso de suelo,\n silvicultura")
guia_I_enc <- scale_fill_brewer(palette = "Accent", name = "Sector",
                                      labels = et_comp)
guia_I_ind <- scale_color_brewer(palette = "Accent", name = "Sector",
                                   labels = et_comp)
# gases
et_gas <- c("CO2", "CH4", "N2O", "HCF's", "CF4", "C2F6", "SF6")
guia_gases <- scale_fill_brewer(palette = "Dark2", name = "Gas", labels = et_gas)
