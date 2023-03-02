library(shiny)
library(tidyverse)
library(bslib)

whisky <- CodeClanData::whisky

islay_whisky <- whisky %>% 
  filter(Region == "Islay") %>% 
  select(Distillery, Body, Sweetness, Smoky, Floral, Medicinal)

islay_pivot <- islay_whisky %>% 
  pivot_longer(cols = 2:6, names_to = "Flavour", values_to = "Score")

flavour_choices <- islay_pivot %>% distinct(Flavour) %>% pull
whisky_choices <- islay_pivot %>% distinct(Distillery) %>% pull

ui <- fluidPage(
  titlePanel("Islay Whiskies"),
  theme = bs_theme(bootswatch = "superhero"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "flavour_profiles",
        label = tags$i(tags$b("Which Flavour Profile?")),
        choices = flavour_choices
      ),
      tags$hr()
    ),
    mainPanel(
      plotOutput("whisky_plot")
    )
  )
)

server <- function(input, output, session) {
  
  output$whisky_plot <- renderPlot(expr ={
    islay_pivot %>% 
      filter(Distillery %in% c("Ardbeg",
                               "Bowmore",
                               "Bruichladdich",
                               "Bunnahabhain",
                               "Caol Ila",
                               "Lagavulin",
                               "Laphroaig")) %>% 
      filter(Flavour == input$flavour_profiles) %>% 
      ggplot() +
      aes(x = Distillery, y = Score, fill = Flavour) +
      geom_col() +
      scale_fill_manual(
        values = c("Body" ="steelblue",
                   "Sweetness" = "red",
                   "Smoky" = "grey20",
                   "Floral" = "orchid",
                   "Medicinal" = "goldenrod")
      )
  })
  
}

shinyApp(ui, server)

