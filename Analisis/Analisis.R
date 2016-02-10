# analizare los datos, ya agrupados
setwd("~/Datos/Calentamiento/Analisis")
library(dplyr)
library(ggplot2)
library(tidyr)
library(xts)
# cargado de datos
datos <- readRDS("../Datos/Datos.Rds")

##  Preprocesado de datos
# emision por año
emision_anio <- datos %>%
                 group_by(anio) %>%
                 summarise(emision_anual = sum(emision))
#saveRDS(emision_anio, "../Datos/Emision_anio.Rds", compress = FALSE)
# emision por jerarquia 1
emision_I <- datos %>% group_by(anio, categoria_1) %>%
                  summarise(emision_I = sum(emision))
#saveRDS(emision_I, "../Datos/Emision_I.RDS", compress = FALSE)

# emision por gas
emision_gas <- datos %>%
               group_by(anio, componente) %>%
               summarise(evolucion_gas = sum(emision))
#saveRDS(emision_gas, "../Datos/Emision_componente.Rds", compress = FALSE)    

## Datos para la interactividad
#ts_I <- spread(emision_I, key = categoria_1, value = emision_I)

## mostrare la jerarquia II
emision_II <- datos %>% 
              group_by(anio, categoria_1, categoria_2) %>%
              summarise(emision_anual = sum(emision))

# separo las listas
categorias_I <- as.character(unique(datos$categoria_1))
emision_II_sep <- vector(mode = "list", length = 7)
names(emision_II_sep) <- c("energía", "procesos_industriales", "uso_suelo", 
                           "desechos", "bunkers", "quema_biomasa", "agricultura")
for (i in c(1:7)) {
    emision_II_sep[[i]] <- filter(emision_II, categoria_1 == categorias_I[i])
}
saveRDS(emision_II_sep, file = "../Datos/Emision_II_sep.Rds", compress = FALSE)

