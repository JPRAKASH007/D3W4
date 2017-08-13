library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
  
  output$plot <- renderPlotly({
    y <- 0:input$Year
    ACI <- 0:input$Year
    ASI <- 0:input$Year
    for (i in 0:input$Year+1) {
      ACI[i] <- input$Amount*(1+input$Rate/100)^y[i]
      ASI[i] <- input$Amount*(1+(input$Rate/100)*y[i])
    }
    
    data <- data.frame(y,ACI,ASI) 
    ## View(data)
    p <- plot_ly(data) %>%
      layout(title = 'Power of Compounding',
             xaxis = list(title = "Years of Investment",showgrid = TRUE,zeroline = TRUE),
             yaxis = list(side = 'left', title = 'Amount ($ Millons)',showgrid = TRUE, zeroline = TRUE),
             legend = list(x = 0.1, y = 0.9),
             hovermode="compare") %>%
      
      add_trace(x = ~y, y = ~ACI,type = 'scatter',visible=input$show_CI,mode="lines",name = 'Compounded growth',
                marker = list(color = "red"),
                hoverinfo = "text",
                text = ~paste("Amount ($M):",round(ACI,digits=1),"<br>Year:",y,"<br>Gain over Simple growth ($M):",round(ACI-ASI,digits=1))) %>%
      
      add_trace(x = ~y, y = ~ASI, type = 'scatter',visible=input$show_SI,mode="lines",name = 'Simple/linear growth',
                marker = list(color = "blue"),
                hoverinfo = "text",
                text = ~paste("Amount ($M):",round(ASI,digits=1),"<br>Year:",y))
    
    
    
  })
  
  output$A <- renderText({
    round(input$Amount*(1+input$Rate/100)^input$Year,digits = 1)
  })
  
  output$B <- renderText({
    input$Amount*(1+(input$Rate/100)*input$Year)
  })
  
})
