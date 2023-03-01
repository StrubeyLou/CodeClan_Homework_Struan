library(shiny)
library(tidyverse)
library(bslib)

whisky <- CodeClanData::whisky

ui <- fluidPage(
  titlePanel("Islay Whiskies"),
  theme = bs_theme(bootswatch = "superhero"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "flavour_profiles",
        label = "Which Flavour Profile?",
        choices = flavour_choices
      ),
      tags$hr()
    ),
    mainPanel(
      plotOutput("whisky_plot")
    )
  )
)
