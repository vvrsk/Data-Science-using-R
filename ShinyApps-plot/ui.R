library(shiny) 
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

shinyUI(pageWithSidebar( 
        headerPanel("Random point plot in Norway"),
        sidebarPanel(h5("This is a random map point generator to display the points on map in Norway created on 3/4/17"), actionButton("recalc", "New points")),
        mainPanel(leafletOutput("mymap"),
        p()
        #actionButton("recalc", "New points")
        )
)
)

