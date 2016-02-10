# servidor
library(shiny)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
# cargado de datos
datos <- readRDS("datos/Datos.Rds")
source("helpers.R")

shinyServer(function(input, output) {
    # preparación de los datos
    emision_anio <- datos %>% group_by(anio) %>%
        summarise(emision_anual = sum(emision))
    
    emision_I <- datos %>% group_by(anio, categoria_1) %>%
        summarise(emision_I = sum(emision))
    
    emision_gas <- datos %>% group_by(anio, componente) %>%
        summarise(evolucion_gas = sum(emision))
    
    # geom sector
    geom_sector_final <- reactive({
        if (input$opciones_comp == "agrupados") {
            if(input$posicion_agrupados == "area") {
                plot_final <- geom_area(alpha = 0.85, aes(fill = categoria_1))
            }
            if(input$posicion_agrupados == "proporcional") {
                plot_final <- plot_proporcion
            }
        plot_final
        }
        if (input$opciones_comp == "individuales") {
            plot_final <- geom_line(size = 1, aes(colour = categoria_1))
        }
        plot_final
    })
    # geom gas
    grafica_componentes <- reactive({
        if (input$opciones_comp == "agrupados") {
            if(input$posicion_agrupados == "area") {
                plot_final <- geom_area(alpha = 0.85)
            }
            if(input$posicion_agrupados == "proporcional") {
                plot_final <- plot_proporcion
            }
        plot_final
        }
        if (input$opciones_comp == "individuales") {
            plot_final <- plot_linea
        }
        plot_final
    })    
    
    ## eje y
    eje_y_final <- reactive({
        if (input$opciones_comp == "agrupados") {
            if (input$posicion_agrupados == "area") {
                eje_vertical <- eje_y_enc
            }
            if (input$posicion_agrupados == "proporcional") {
                eje_vertical <- eje_y_prop
            }
            eje_vertical
        }
        if (input$opciones_comp == "individuales") {
            eje_vertical <- eje_y_ind
        }
        eje_vertical
    })
    
    ## eje x
    eje_x_final <- reactive({
        if (input$posicion_agrupados == "area") {
            eje_x_f <- eje_x
        }
        if (input$posicion_agrupados == "proporcional") {
            eje_x_f <- eje_x_prop
        }       
        eje_x_f
    })
    ## nombre eje y
    ylab_final <- reactive({
        if (input$posicion_agrupados == "area") {
            ylab_f <- ylab("Emisión de CO2 [Gkg]")
        }
        if (input$posicion_agrupados == "proporcional") {
            ylab_f <- ylab("Porcentaje")
        }       
        ylab_f
        })

    
    ## Guias para obtener los datos
    
    guia_sector_final <- reactive ({
        if (input$opciones_comp == "individuales") { 
            guia_sector <- guia_I_ind
        } else {
            guia_sector <- guia_I_enc
        } 
        guia_sector
    })
    
    # ajuste lineal
    ajuste <- reactive({
        if(input$ajuste == TRUE) {
            geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) 
        } else {
            
        }
    })

    # aca van las gráficas
    output$plot_anual <- renderPlot({
        ggplot(data = emision_anio, aes(x = anio, y = emision_anual)) +
            geom_point(size = 2.5, colour = "steelblue4") +
            ajuste() +
            eje_y_enc +
            eje_x +
            coord_cartesian(xlim = c(input$rango_anios)) +
            labs(x = "Año", y = "Emision anual [Gkg]") +
            ggtitle("Emisión anual de CO2") +
            estilo
    })
    output$plot_sector <- renderPlot({
        ggplot(data = emision_I, aes(x = anio, y = emision_I)) +
            geom_sector_final() +
            eje_y_final() +
            eje_x_final() +
            coord_cartesian(xlim = c(input$rango_anios)) +
            guia_sector_final() +
            labs(x = "Año", title = "Emision de gases de efecto invernadero") + 
            ylab_final() +
            estilo
    })
        
    output$plot_gas <- renderPlot({
        ggplot(data = emision_gas, aes(x = anio, y = evolucion_gas)) +
            grafica_componentes() +
            eje_y_final() +
            eje_x_final() +
            coord_cartesian(xlim = c(input$rango_anios)) +
            guia_gases +
            labs(x = "Año", y = "Porcentaje") +
            ggtitle("Emision de gases de efecto invernadero") +
            estilo
    })
      
})