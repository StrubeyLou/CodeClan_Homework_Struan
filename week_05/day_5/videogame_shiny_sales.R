library(tidyverse)
library(CodeClanData)
library(shiny)

videogames <- CodeClanData::game_sales


library(shiny)

ui <- fluidPage(
  titlePanel("Best Selling Games"),
  
  sidebarLayout(
    sidebarPanel(
      
     sliderInput("slider_sales", 
                 label = h3("How Much?"), min = 0, 
                               max = 85, value = c(20, 30))
    ),
    mainPanel(
      plotOutput("sales_plot")
    )
  )
)

server <- function(input, output, session) {
  output$sales_plot <- renderPlot({
    
    videogames %>%
      filter(sales == input$slider_sales) %>%
      ggplot() +
      aes(x = name, y = sales) +
      geom_point() 
  })
}

shinyApp(ui, server)