# éste script visualiza los datos 
setwd("~/Datos/Calentamiento/Analisis")
library(ggplot2)
#library(plotly)

# cargado de datos
emision_anio <- readRDS("../Datos/Emision_anio.Rds")
emision_I <- readRDS("../Datos/Emision_I.RDS")
emision_gas <- readRDS("../Datos/Emision_componente.Rds")
source("graph_helpers.R")
## Graficado 

# emision anual
#png(filename = "../Imagenes/Emision_anual.png", height = 675, width = 1200)
ggplot(data = emision_anio, aes(x = anio, y = emision_anual)) +
    geom_point(size = 3, colour = "steelblue4") +
    geom_smooth(method = "lm", se = FALSE) +
    eje_x_global +
    scale_y_continuous(breaks = seq(from = 6e5, to = 8e5, by = 5e4),
                       labels = as.character(seq(from = 600, to = 800, by = 50))) +
    labs(x = "Año", y = "Emision anual [Gkg]") +
    ggtitle("Emisión anual de CO2") +
    estilo
#dev.off()

# composición de las emisiones anuales
#png(filename = "../Imagenes/Emision_I.png", height = 675, width = 1200)
ggplot(data = emision_I, aes(x = anio, y = emision_I, fill = categoria_1)) +
    geom_area(alpha = 0.85) + 
    scale_y_continuous(breaks = seq(from = 0, to = 8e5, by = 1e5), expand = c(0.01, 0),
                       labels = as.character(seq(from = 0, to = 800, by = 100))) +
    eje_x_proporcional +
    scale_fill_brewer(palette = "Accent", name = "Categoria", labels = etiquetas_I) +
    labs(x = "Año", y = "Emisión anual de CO2 [Gkg]") + 
    ggtitle("Emisión anual de CO2 por categoria") + 
    estilo
#dev.off()

# Evolución de las emisiones de los diferentes gases de efecto invernadero
#png(filename = "../Imagenes/Emision_gas.png", height = 675, width = 1200)
ggplot(data = emision_gas, aes(x = anio, y = evolucion_gas, fill = componente)) +
           geom_area(alpha = 0.85) + 
    scale_y_continuous(breaks = seq(from = 0, to = 8e5, by = 1e5), expand = c(0.01, 0),
                       labels = as.character(seq(from = 0, to = 800, by = 100))) +
    eje_x_proporcional +
    scale_fill_brewer(palette = "Dark2", name = "Gas", labels = etiquetas_gas) +
    labs(x = "Año", y = "Emisión anual de CO2 [Gkg]") +
    ggtitle("Emision de gases de efecto Invernadero") +
    estilo
#dev.off()

## Ahora los graficare separados

# categoria 1
#png(filename = "../Imagenes/Emision_I_lineal.png", height = 675, width = 1200)
ggplot(data = emision_I, aes(x = anio, y = emision_I, colour = categoria_1)) +
    geom_line(size = 1.3) + 
    geom_smooth(method = "lm", se = FALSE) +
    scale_y_discrete(breaks = seq(from = 0, to = 5e5, by = 1e5),
                       labels = as.character(seq(from = 0, to = 500, by = 100))) +
    eje_x_proporcional +
    scale_color_brewer(palette = "Accent", name = "Categoria", labels = etiquetas_I) +
    labs(x = "Año", y = "Emisión anual de CO2 [Gkg]") + 
    ggtitle("Emisión anual de Co2 por categoria") + 
    estilo
#dev.off()

# por gases
#png(filename = "../Imagenes/Emision_gas_lineal.png", height = 675, width = 1200)
ggplot(data = emision_gas, aes(x = anio, y = evolucion_gas, colour = componente)) +
    geom_line(size = 1.5, aes(fill = componente)) + 
    geom_smooth(method = "lm", se = FALSE) +
    scale_y_continuous(breaks = seq(from = 0, to = 5.5e5, by = 1e5),
                       labels = as.character(seq(from = 0, to = 550, by = 100))) +
    eje_x_proporcional +
    scale_color_brewer(palette = "Dark2", name = "Gas", labels = etiquetas_gas) +
    labs(x = "Año", y = "Emisión anual de CO2 [Gkg]") +
    ggtitle("Emision de gases de efecto Invernadero") +
    estilo
#dev.off()

# ahora como porcentaje 

# categoria 1
#png(filename = "../Imagenes/Emision_I_proporcion.png", height = 675, width = 1200)
ggplot(data = emision_I, aes(x = anio, y = emision_I, fill = categoria_1)) +
    geom_area(size = 1, position = "fill", aes(ymax = 1), alpha = 0.8) +
    scale_y_continuous(breaks = seq(from = 0, to = 1, by = 0.1), expand = c(0,0)) +
    eje_x_proporcional +
    scale_fill_brewer(palette = "Accent", name = "Categoria", labels = etiquetas_I) +
    labs(x = "Año", y = "Porcentaje") + 
    ggtitle("Participación anual en la emisión de CO2") + 
    estilo
#dev.off()

# Gases
#png(filename = "../Imagenes/Emision_gas_proporcion.png", height = 675, width = 1200)
ggplot(data = emision_gas, aes(x = anio, y = evolucion_gas, fill = componente)) +
    geom_area(size = 1, position = "fill", aes(ymax = 1), alpha = 0.8) +
    scale_y_continuous(breaks = seq(from = 0, to = 1, by = 0.1), expand = c(0,0)) +
    eje_x_proporcional +
    scale_fill_brewer(palette = "Dark2", name = "Gas", labels = etiquetas_gas) +
    labs(x = "Año", y = "Porcentaje") +
    ggtitle("Composición de gases de efecto Invernadero") +
    estilo
#dev.off()

# plotly
m <- ggplot(data = emision_I, aes(x = anio, y = emision_I, colour = categoria_1)) +
    geom_line(size = 1.3) + 
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(facets = ~ categoria_1, ncol = 4, scales = "fixed") +
    scale_y_discrete(breaks = seq(from = 0, to = 5e5, by = 1e5),
                     labels = as.character(seq(from = 0, to = 500, by = 100))) +
    eje_x_proporcional +
    scale_color_brewer(palette = "Accent", name = "Categoria", labels = etiquetas_I) +
    labs(x = "Año", y = "Emisión anual de CO2 [Gkg]") + 
    ggtitle("Emisión anual de Co2 por categoria") + 
    estilo


