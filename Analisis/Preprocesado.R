# este ecript preprocesa los datos descargados del INECC
setwd("~/Datos/Calentamiento/Analisis")
library(xlsx)
library(dplyr)
library(stringr)
library(tidyr)

# cargado de los datos

# abri el archivo con libre oficce, parte manual
nombres <- c("categoria", "co2", "ch4", "n2o", "hcfs", "cf4", "c2f6", "sf6")
# creo los contadores, hoja y año
hoja <- seq.int(21)
anio <- seq(from = 1990, to = 2010, by = 1)
# matriz del tamaño final vacia
datos_juntos <- data.frame()

# magia
for ( i in hoja) {
datos <- read.xlsx("../Datos Crudos/inf_inegei_serie_tiempo_2010.xls", header = FALSE, 
                   sheetIndex = hoja[i], rowIndex = c(8:101, 103:106), 
                   colIndex = c(1:8), row.names = NULL, stringsAsFactors = FALSE) %>%
         mutate(X1 = tolower(X1)) %>%
         tbl_df() 
# agrego los nombres de las variables y elimino los espacios
names(datos) <- nombres
datos$categoria <- str_trim(datos$categoria)
## Jerarquia I
# Creo columnas con las categoriasd
categoria_1 <- c(rep.int("energia", 29), rep.int("procesos industriales", 18), 
                 rep("agricultura", 31), rep.int("suelo y silvicultura", 5), 
                 rep.int("desechos (ipcc 2006)", 6), rep.int("bunkers", 2), 
                 "quema de biomasa")
# elimino la jerarquia 1
nombres_cat_1 <- c("energía", "procesos industriales", "agricultura", "bunkers",
                   "uso del suelo, cambio de uso del suelo y silvicultura",
                   "desechos (ipcc 2006)")
datos_1 <- datos[- which(datos$categoria %in% nombres_cat_1), ]
# agrego la categoria I
datos_1$categoria_1 <- categoria_1

## Jerarquia II

categoria_2 <- c(rep.int("consumo combustibles fosiles", 19), 
                 rep.int("emisiones fugitivas", 8), rep.int("industria minerales", 4), 
                 rep.int("industria quimica", 5), rep.int("industria metales", 4), 
                 rep.int("halocarbonos y hexafluoruro de S", 2),
                 rep.int("fermentacion enterica", 9), rep.int("manejo estiercol", 13),
                 rep.int("cultivo de arroz", 3), "manejo suelos agricolas",
                 "quemas programadas suelos", "quemas en campo residuos agrícolas",
                 "cambios de biomasa vegetacion leñosa", 
                 "conversion bosques y pastizales", "captura por abandono de tierras", 
                 "emisiones y remociones de CO2", "asentamientos", 
                 rep.int("desechos solidos", 2), "incineracion desechos", 
                 rep.int("aguas residuales", 2), "aviacion internacional", 
                 "navegacion internacional", datos_1$categoria_1[92])
# elimino la jerarquia 2
nombres_cat_2 <- c("consumo de combustibles fósiles", "emisiones fugitivas",
                   "industria de los minerales", "industria química", 
                   "industria de los metales", "fermentación entérica", 
                   "manejo de estiércol", "cultivo de arroz",
                   "tratamiento y eliminación de aguas residuales")
datos_2 <- datos_1[-which(datos_1$categoria %in% nombres_cat_2), ]
# agrego la categoria 2
datos_2$categoria_2 <- categoria_2

## jerarquia 3
categoria_3 <- c(rep.int("industrias de la energia", 2), 
                 rep.int("manufactura/industria construcción", 6),
                 rep.int("transporte",4), rep.int("otros sectores", 3),
                 rep.int("combustibles solidos", 3), rep.int("petroleo/gas natural", 3),
                 datos_2$categoria[28:40], "produccion halocarbonos hexafluoruro de S",
                 "consumo halocarbonos y hexafluoruro de S",
                 rep.int("vacas", 2), datos_2$categoria[46:51], 
                 rep.int("vacas", 2),
                 datos_2$categoria[55:78], 
                 "tratamiento eliminación aguas residuales domésticas",
                 "tratamiento eliminación aguas residuales industriales",
                 datos_2$categoria[81:83])
# elimino la jerarquia 3
nombres_cat_3 <- c("industrias de la energía",
                   "manufactura e industria de la construcción",
                   "transporte",
                   "otros sectores (comercial, residencial y agropecuario)",
                   "combustibles sólidos",                   
                   "petróleo y gas natural",
                   "vacas") 
datos_3 <- datos_2[- which(datos_2$categoria %in% nombres_cat_3), ]
datos_3$categoria_3 <- categoria_3

## Jerarquia 4
# elimino la jerarquia 4
nombres_cat_4 <- c("minería de carbón")
datos_4 <- datos_3[-which(datos_3$categoria %in% nombres_cat_4), ]
# categoria 4
categoria_4 <- datos_3$categoria[- which(datos_3$categoria %in% nombres_cat_4)]
datos_4$categoria_4 <- categoria_4

# agrego el año
datos_4$anio <- anio[i]

# los pego al final
datos_juntos <- rbind(datos_juntos, datos_4)

rm(datos, datos_1, datos_2, datos_3, datos_4)
gc()
}

# agrupo los datos
datos_agrupados <- gather(data = datos_juntos, key = componente,
                          value = emision, co2:sf6) %>%
                    filter(emision != "NA", emision != 0) %>% tbl_df()
datos <- datos_agrupados
# lo guardo 
#write.table(datos, "../Datos/Datos.csv", row.names = FALSE, sep = ",")
saveRDS(datos, "../Datos/Datos.Rds", compress = FALSE)
 