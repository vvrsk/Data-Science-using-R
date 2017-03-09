library(shiny)
library(rCharts)
library(leaflet)

shinyServer(function(input, output, session) {
        
        points <- eventReactive(input$recalc, {
                cbind(rnorm(30)+10, -rnorm(30)+60)
        }, ignoreNULL = FALSE)
        
        output$mymap <- renderLeaflet({
                leaflet() %>%
                        addProviderTiles(providers$Stamen.TonerLite,
                                         options = providerTileOptions(noWrap = TRUE)
                        ) %>%
                        addMarkers(data = points())
        })
}
)