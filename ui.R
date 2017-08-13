library(shiny)
library(ggplot2)
library(plotly)

shinyUI(fluidPage(

  titlePanel("Power of Compounding"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("Amount", "Initial Investment ($ Millions)", 
                   value = 10, min = 1, max = 100, step = 1), 
      
      sliderInput("Year", "No. of Years of Investment",
                  min = 0,max = 30,value = 20),
      
      numericInput("Rate","Annual Rate of Interest (%)",
                   min = 0,max = 20,value = 10,step = .1),
      
      checkboxInput("show_CI", "Show/Hide Investment projections with Compounded growth", value = TRUE),
      
      checkboxInput("show_SI", "Show/Hide Investment projections with Simple/Linear growth", value = FALSE),
      
      h4("------------------------------"),
      h4("Instructions to use the app"),
      h5("Input the following"),
      h5("- Initial Investment in $ Millions"),
      h5("- No. of Years of Investment"),
      h5("- Annual Rate of Interest (%)")
      
    ),
    
    mainPanel(
      plotlyOutput("plot"),
      h4("Total value of investment (with compounded growth) - $M :"),
      textOutput("A"),
      h4("Total value of investment (with simple/linear growth) - $M :"),
      textOutput("B")
    )
  )
))
