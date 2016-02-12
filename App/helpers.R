# codigo de soporte para server.R 

### Graficado

# stilo
estilo <- theme(text = element_text("Trebuchet MS", "bold", "#666666"),
                plot.title  = element_text(size = 25),
                axis.title  = element_text(size = 16),
                axis.text.x = element_text(size = 12, colour = "gray15"),
                legend.position = "bottom")
 
## Marcas
# x
marcas_x     <- seq(1990, 2010, by = 5)
marquitas_x  <- seq(1990, 2010, 1)
# y
marcas_y_enc <- seq(0, 8e5, by = 1e5)
marcas_y_ind <- seq(0, 5e5, by = 1e5)

# eje y
eje_y_enc <- scale_y_continuous(breaks = marcas_y_enc, expand = c(0, 1e4),
                                labels = as.character(seq(0, 800, by = 100)))
eje_y_ind <- scale_y_discrete(breaks = marcas_y_ind, expand = c(0, 1e4), 
                              labels = c("0", "100", "200", "300", "400", "500"))
eje_y_prop <- scale_y_continuous(breaks = seq(0, 1, by = 0.1), expand = c(0, 0),
                                 minor_breaks = NULL)
eje_y_anual <- scale_y_continuous(breaks = seq(6e5, 8e5, by = 5e4), expand = c(0, 1e4),
                                  label = c("600", "650", "700", "750","800"))
# eje x
eje_x <- scale_x_continuous(breaks = marcas_x, expand = c(0, 0.35),
                                minor_breaks = marquitas_x) 
eje_x_prop <- scale_x_continuous(breaks = marcas_x, expand = c(0, 0.35),
                                 minor_breaks = marquitas_x)

## Guias
# categoria I
et_comp <- c("Agricultura", "Transporte\ninternacional", "Desechos",
             "Quema de\nbiomasa", "Energía", "Procesos\nindustriales",
             "Uso/cambio de uso\nde suelo,\nsilvicultura")
guia_I_enc <- scale_fill_brewer(palette = "Accent", name = "Sector",
                                      labels = et_comp)
guia_I_ind <- scale_color_brewer(palette = "Accent", name = "Sector",
                                   labels = et_comp)
# gases
et_gas <- list(TeX('$CO_{2}$'), TeX('$CH_{4}$'), TeX('$N_{2}O$'), TeX("HCF's"), 
               TeX('$CF_{4}$'), TeX('$C_{2}F_{6}$'), TeX('$SF_{6}$'))
guia_gases_enc <- scale_fill_brewer(palette = "Dark2", name = "Gas", labels = et_gas)
guia_gases_ind <- scale_color_brewer(palette = "Dark2", name = "Gas", labels = et_gas)

