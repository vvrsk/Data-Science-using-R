library(shiny)
library(plotly)

shinyServer(
        function(input, output) {  
                
               dataset <- reactive({df<- (towed_vehicles[towed_vehicles$Make == input$type & towed_vehicles$`Towed to Address` == input$color, ])})
                output$add <- renderText({paste("Make of Car is:", input$type)})
                #output$Controls <- renderUI({list(selectInput("type", "Select Type of vehicle", make, selected=name[1]),
                #                                 selectInput("color", "Select color code", color, selected=name[2])
                #                                )
                #        })
             
        output$myChart <- renderPlotly({
                
                p <- plot_ly(dataset(), x = ~Make, type = "histogram", color = ~Color)
                
        }) 
        output$location_chart <- renderPlotly({
                
                p <- plot_ly(towed_vehicles, x = ~`Towed to Address`, type = "histogram", color = ~Make)
                
        })
        
        output$location_chart_aggr <- renderPlotly({
                
                p <- plot_ly(towed_vehicles, x = ~`Towed to Address`, type = "histogram",  text = ~paste('Make of Cars: ', Make))
                
        })
        
        output$table <- renderDataTable(towed_vehicles)
        
        
        txt <- "<br/> <font size='4'>Hello, Thanks for Coming here!! <br/> </font size>
                <ul>
                <li>This is an analyis of how Towed Vechicles are stacked in the 4 different Auto Pounds of <b>City of Chicago</b>. </li>
                <li>For this analysis I considered the data for the last 4 months (Dec 2016 - Feb 2017) and can be seen in the <b>Data Table</b> Tab of the Graph.</li> 
                <li>The <b>Make Anlaysis</b> gives the distribution of cars based on their Make and Color across these Auto Pounds.</li>
                <li>The <b>Auto Pounds Aggregate</b> gives the Aggrate analysis of Auto ponds and the <b>Location Analysis</b> gives the distribution of different vechicles available in each Auto Pound.</li>
                </ul>"
        
        output$summary <- renderUI({ 
               HTML(paste(txt))
        })
        
        
                }) 

        
