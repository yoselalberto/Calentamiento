# interface de la app

shinyUI(fluidPage(
  
    titlePanel("Emisión de gases de efecto invernadero en México"),
    
    sidebarLayout(
        
        sidebarPanel(
            p("Evolución de la emisión de gases de efecto invernadero en México, por sector ó por gas 1990 al 2010"),
            
            conditionalPanel(condition = "input.pestania != 'anual'",
                radioButtons(inputId = "opciones_comp", label = "Datos",
                             c("Individuales" = "individuales",
                                "Agrupados" = "agrupados"),
                             selected = "individuales")
            ),
            conditionalPanel(condition = "input.pestania != 'anual' && input.opciones_comp == 'agrupados'",
                radioButtons(inputId = "posicion_agrupados", label = "Tipo de gráfica",
                             c("Area" = "area", 
                               "Proporcional" = "proporcional"),
                             selected = "area")
            ),
            
            conditionalPanel(condition = "input.pestania == 'anual'",
                             checkboxInput("ajuste", "Agregar un ajuste lineal", FALSE)
            ),
            
            # rango de años a mostrar (zoom)
            sliderInput("rango_anios", "Mostrar años",
                        min = 1990, max = 2010, step = 1,
                        value = c(1990, 2010), ticks = FALSE),
            helpText("Nota: CO2 equivalente")
        ),
        
        mainPanel(
            tabsetPanel(id = "pestania",
                tabPanel(title = "Anual", plotOutput("plot_anual"), value = "anual"),
                tabPanel(title = "Sector", plotOutput("plot_sector", height = "500px"), value = "sector"),
                tabPanel(title = "Gas", plotOutput("plot_gas", height = "500px"), value = "gas")
            )
        )
    )
))