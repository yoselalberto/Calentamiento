# interface de la app

shinyUI(fluidPage(
  
    titlePanel("Emision de gases de efecto invernadero en México"),
    
    sidebarLayout(
        
        sidebarPanel(
            p("Emisión de gases de efecto invernadero
            en México del 1990 al 2010"),
            
            conditionalPanel(condition = "input.pestania != 'anual'",
                radioButtons(inputId = "opciones_comp", label = "Posición de los datos",
                             c("Agrupados" = "agrupados",
                               "Individuales" = "individuales"),
                             selected = "agrupados")
            ),
            conditionalPanel(condition = "input.pestania != 'anual' & input.opciones_comp == 'agrupados'",
                radioButtons(inputId = "posicion_agrupados", label = "Tipo de gráfica",
                             c("Area" = "area", 
                               "Proporcional" = "proporcional"),
                               selected = "area")
            ),
            
            conditionalPanel(condition = "input.pestania == 'anual'",
                             checkboxInput("ajuste", "Agregar un ajuste lineal", FALSE)
            ),
            
            # rango de años a mostrar (zoom)
            sliderInput("rango_anios", "Rango de años",
                        min = 1990, max = 2010, step = 1,
                        value = c(1990, 2010), ticks = FALSE)
        ),
        
        mainPanel(
            tabsetPanel(id = "pestania",
                tabPanel(title = "Anual", plotOutput("plot_anual"), value = "anual"),
                tabPanel(title = "Componentes", plotOutput("plot_componentes"), value = "componente"),
                tabPanel(title = "Gas", plotOutput("plot_gas"), value = "gas")
            )
        )
    )
))