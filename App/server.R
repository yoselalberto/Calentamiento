# servidor

library(shiny)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
# cargado de datos
datos <- readRDS("datos/Datos.Rds")
source("helpers.R")

shinyServer(function(input, output) {
    # preparación de datos
    emision_anio <- datos %>% group_by(anio) %>%
        summarise(emision_anual = sum(emision))
    
    emision_I <- datos %>% group_by(anio, categoria_1) %>%
        summarise(emision_I = sum(emision))
    
    emision_gas <- datos %>% group_by(anio, componente) %>%
        summarise(evolucion_gas = sum(emision))
    
    # datos agrupados
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
    eje_y_agrupados <- reactive({
        if (input$opciones_comp == "agrupados") {
            if (input$posicion_agrupados == "area") {
                eje_vertical <- eje_y_global_stack
            }
            if (input$posicion_agrupados == "proporcional") {
                eje_vertical <- eje_y_proporcional
            }
            eje_vertical
        }
        if (input$opciones_comp == "individuales") {
            eje_vertical <- eje_y_individual
        }
        eje_vertical
    })
    
    ## eje x
    eje_x_final <- reactive({
        if (input$posicion_agrupados == "area") {
            eje_x <- eje_x_global
        }
        if (input$posicion_agrupados == "proporcional") {
            eje_x <- eje_x_proporcional
        }       
        eje_x
    })
    
    ## Guias para obtener los datos
    
    guia_componente <- reactive ({
        if (input$opciones_comp == "agrupados") {
            guia_comp <- guia_I_agrupados
        }        
        if (input$opciones_comp == "individuales") { 
            guia_comp <- guia_I_linea
        }
        guia_comp
    })
    
    # ajuste lineal opcional
    ajuste <- reactive({
        if(input$ajuste == TRUE) {
            geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) 
        } else {
            
        }
    })

    # aca van las gráficas
    output$plot_anual <- renderPlot({
        ggplot(data = emision_anio, aes(x = anio, y = emision_anual)) +
            plot_dispersion +
            ajuste() +
            eje_y_global_stack +
            eje_x_global +
            coord_cartesian(xlim = c(input$rango_anios + c(- 0.5, 0.5))) +
            labs(x = "Año", y = "Emision anual [Gkg]") +
            ggtitle("Emisión anual de CO2") +
            estilo
    })
    output$plot_componentes <- renderPlot({
        ggplot(data = emision_I, aes(x = anio, y = emision_I, fill = categoria_1)) +
            grafica_componentes() +
            eje_y_agrupados() +
            eje_x_final() +
            coord_cartesian(xlim = c(input$rango_anios)) +
            guia_componente() +
            labs(x = "Año", y = "Porcentaje") + 
            ggtitle("Participación anual en la emisión de CO2") + 
            estilo
    })
        
    output$plot_gas <- renderPlot({
        ggplot(data = emision_gas, aes(x = anio, y = evolucion_gas, fill = componente)) +
            grafica_componentes() +
            eje_y_agrupados() +
            eje_x_final() +
            coord_cartesian(xlim = c(input$rango_anios)) +
            guia_gases +
            labs(x = "Año", y = "Porcentaje") +
            ggtitle("Composición de gases de efecto Invernadero") +
            estilo
    })
    
    
})