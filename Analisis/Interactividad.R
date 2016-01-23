# preparación de los datos para visualizaciones interactivas
setwd("~/Datos/Calentamiento/Analisis")
library(dplyr)
library(tidyr)
library(xts)
library(dygraphs)
library(RColorBrewer)

# cargo los datos
emision_anio <- readRDS("../Datos/Emision_anio.Rds")
emision_I    <- readRDS("../Datos/Emision_I.RDS")
emision_gas  <- readRDS("../Datos/Emision_componente.Rds")
emision_II_sep   <- readRDS("../Datos/Emision_II_sep.Rds")

# transformación a series temporales
ts_anio <- ts(emision_anio$emision_anual, start = 1990, end = 2010)
#saveRDS(ts_anio, file = "../Datos/ts_anio.Rds", compress = FALSE)
emision_I_w    <- spread(emision_I, key = categoria_1, value = emision_I) %>%
                  select(-anio)
names(emision_I_w) <- c("agricultura","bunkers", "desechos", "quema_biomasa",
                        "energía", "procesos_industriales", "uso_suelo")
ts_I <- lapply(emision_I_w, FUN = ts, start = 1990, end = 2010) %>%
        lapply(FUN = as.xts)
ts_I <- cbind(ts_I[[1]], ts_I[[2]], ts_I[[3]], ts_I[[4]], ts_I[[5]], ts_I[[6]], ts_I[[7]])
names(ts_I) <- c("agricultura","bunkers", "desechos", "quema_biomasa",
                        "energía", "procesos_industriales", "uso_suelo")
#saveRDS(ts_I, file = "../Datos/ts_I.Rds", compress = FALSE)
emision_gas_w <- spread(emision_gas, componente, value = evolucion_gas) %>%
                 select(-anio)
ts_gas <- lapply(emision_gas_w, FUN = ts, start = 1990, end = 2010) %>%
          lapply(FUN = as.xts)
ts_gas <- cbind(ts_gas[[1]], ts_gas[[2]], ts_gas[[3]], ts_gas[[4]], ts_gas[[5]], ts_gas[[6]],
                ts_gas[[7]])
names(ts_gas) <- names(emision_gas_w)
#saveRDS(ts_gas, file = "../Datos/ts_gas.Rds", compress = FALSE)

## Segunda jerarquia
emision_II_sep_w <- spread(emision_II_sep)

