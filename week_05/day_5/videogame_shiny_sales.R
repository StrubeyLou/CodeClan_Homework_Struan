library(tidyverse)
library(CodeClanData)
library(shiny)

videogames <- CodeClanData::game_sales

# This list was created to highlight the sales figures of videogames. 
# There are very few which make it into the tens of millions of sales but those that are should be highlighted. 
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
    sales_range <- input$slider_sales
    videogames %>%
      filter(between(sales, sales_range[1], sales_range[2])) %>%
      ggplot() +
      aes(x = name, y = sales) +
      geom_point() +
      coord_flip()
  })
}

shinyApp(ui, server)