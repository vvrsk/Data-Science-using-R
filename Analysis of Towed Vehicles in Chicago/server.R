library(shiny)
library(plotly)

library(readr)
towed_vehicles <- read_csv("./data/Towed_Vehicles.csv", 
                           col_types = cols(Model = col_skip(), 
                                            Plate = col_skip(), State = col_skip(), 
                                            Style = col_skip(), `Tow Facility Phone` = col_skip()))

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
        
        
        txt <- " <b> <font size='4'> Introduction </b></ font size>
                <br/>

        <p>The following visual analysis is a visual depiction of the Towed Vehicles data in City of Chicago. This can be used as a pre analysis of finding the make of most towed vehicles and their color and where they have been towed to (Auto Pounds). </p>

        <b><font size='4'>Data</b></ font size>

        <p>The data for this can be found at the City of Chicago's Website(https://data.cityofchicago.org/Transportation/Towed-Vehicles/ygr5-vcbg)</p>
        For this analysis I considered the data for the last 4 months (Dec 2016 - Feb 2017) and can be seen in the Data Table Tab of the Graph.</p>

                <br/> <font size='4'>Hello, Thanks for Coming here!! <br/> </font size>
                <ul>
                <li>This is an analyis of how Towed Vechicles are stacked in the 4 different Auto Pounds of <b>City of Chicago</b>. </li>
                <li>For this analysis I considered the data for the last 4 months (Dec 2016 - Feb 2017) and can be seen in the <b>Data Table</b> Tab of the Graph.</li> 
                <li>The <b>Make Anlaysis</b> gives the distribution of cars based on their Make and Color across these Auto Pounds.</li>
                <li>The <b>Auto Pounds Aggregate</b> gives the Aggrate analysis of Auto ponds and the <b>Location Analysis</b> gives the distribution of different vechicles available in each Auto Pound.</li>
                </ul>"
        
        txt2<- " 


<br/> <b><font size='4'>Observations<br/> </b></font size>

From the graphs, we can observe many things, but these are the key observations made my me.
<ul>
<li> Most of the Vehicles ar econcentrated in just two of the 4 available Auto Pounds </li>
<li> The reason for the concentration of the cars being more in the other two ponds could be many.</li>
<li> The reason why the two pounds have lower concentration is because they are both fundamentally smaller than the other two and one of them is in Down Town of Chicago and other is near O'Hare Airport(1 hr drive from Down Town) both of which are not great locations for holding th etowed vehicles for security and logistic purposes.</li>
<li> This analysis can be used to find if there is any relation between the Car and its color on the locaction where it is held and to find out the most number of vehicles that are held ina  Auto Pound </li>"
        output$summary <- renderUI({ 
               HTML(paste(txt,txt2,sep = '<br/>'))
        })
        
        
                }) 

        
