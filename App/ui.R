# interface de la app

shinyUI(fluidPage(
  
    titlePanel("Greenhouse effect gas emission in Mexico"),
    
    sidebarLayout(
        
        sidebarPanel(
            p("Evolution of greenhouse effect gas emission in Mexico, per industry or per gas from 1990 to 2010"),
            
            conditionalPanel(condition = "input.pestania != 'anual'",
                radioButtons(inputId = "opciones_comp", label = "Data",
                             c("Individual" = "individuales",
                                "Grouped" = "agrupados"),
                             selected = "individuales")
            ),
            conditionalPanel(condition = "input.pestania != 'anual' && input.opciones_comp == 'agrupados'",
                radioButtons(inputId = "posicion_agrupados", label = "Kind of graph",
                             c("Area" = "area", 
                               "Proportional" = "proporcional"),
                             selected = "area")
            ),
            
            conditionalPanel(condition = "input.pestania == 'anual'",
                             checkboxInput("ajuste", "Add a linear adjust", FALSE)
            ),
            
            # rango de años a mostrar (zoom)
            sliderInput("rango_anios", "Range of years",
                        min = 1990, max = 2010, step = 1,
                        value = c(1990, 2010), ticks = FALSE),
            p("*:", a("equivalent carbon dioxide", href = "https://en.wikipedia.org/wiki/Carbon_dioxide_equivalent"))
        ),
        
        mainPanel(
            tabsetPanel(id = "pestania",
                tabPanel(title = "Annual", plotOutput("plot_anual"), value = "anual"),
                tabPanel(title = "Sector", plotOutput("plot_sector", height = "500px"), value = "sector"),
                tabPanel(title = "Gas", plotOutput("plot_gas", height = "500px"), value = "gas")
            )
        )
    )
))