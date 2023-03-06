library(tidyverse)
library(CodeClanData)
library(shiny)

videogames <- CodeClanData::game_sales

# Games of the Year
best_videogames <- videogames %>% 
  select(name, year_of_release, critic_score, sales, developer) %>% 
  group_by(name, developer, year_of_release) %>% 
  summarise(avg_critic_score = mean(critic_score), total_sales = sum(sales), .groups = "drop") %>% 
  group_by(year_of_release) %>% 
  slice_max(avg_critic_score, n = 10, with_ties = FALSE)

# I created this list as it made me nostalgic for the games I played as a teenager. 
# However categorising all the top reviewed games of each year is a great way to see how there was more consensus in the early 2000s about good quality games compared to the 2010s. Or of course there could be less good games out there. 

library(shiny)

ui <- fluidPage(
  titlePanel("Games of the Year"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("year_input",
                  "Which Year?",
                  choices = c(2000:2016),
                  selected = 2007
      )
    ),
    mainPanel(
      plotOutput("games_plot")
    )
  )
)

server <- function(input, output, session) {
  output$games_plot <- renderPlot({
    
    best_videogames %>%
      filter(year_of_release == input$year_input) %>%
      ggplot() +
      aes(x = name, y = avg_critic_score, size = total_sales, colour = developer) +
      geom_point() +
      coord_flip() +
      labs(x = "Title", y = "Critic Score")
  })
}

shinyApp(ui, server)