library(shiny)
library(plotly)


library(readr)
towed_vehicles <- read_csv("./data/Towed_Vehicles.csv", 
                           col_types = cols(Model = col_skip(), 
                                            Plate = col_skip(), State = col_skip(), 
                                            Style = col_skip(), `Tow Facility Phone` = col_skip()))

make <- unique(sort(towed_vehicles$Make))
color<- unique(sort(towed_vehicles$Color))
tow_to <-unique(sort(towed_vehicles$`Towed to Address`))

shinyUI(fluidPage( 
        headerPanel("Visual Analysis of Towed Vehicles in City of Chicago"),  
        #sidebarPanel(
        #        h3("Control Subpanel"), 
        #        selectInput("type", "Select Type of vehicle", choices = make, selected=name[1]),
        #        selectInput("color", "Select color code", choices = tow_to, selected=name[2])
        #        ),  
        mainPanel(
                
                tabsetPanel(
                tabPanel("Summmary",htmlOutput("summary")),
                tabPanel("Make analysis",h3(textOutput("add")),
                            selectInput("type", "Select Type of vehicle", choices = make),
                            selectInput("color", "Select color code", choices = tow_to),
                            plotlyOutput('myChart',height = "470px")
                         ),
                tabPanel("Location Analysis",plotlyOutput('location_chart',height = "550px")),
                tabPanel("Auto Pounds Aggregate",plotlyOutput('location_chart_aggr',height = "550px")),
                tabPanel("Data Table", dataTableOutput("table"))
        ))
))