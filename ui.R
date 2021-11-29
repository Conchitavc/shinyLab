
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Interacciones del usuario con graficas"),
  tabsetPanel(
    tabPanel('Interacciones con Plots',
      fluidRow(
        tabPanel(
          "2 columns",
          fluidRow(
            column(width = 6,plotOutput("plot_click_options", click = "clk", brush = 'mouse_brush', dblclick = 'dclk', hover =  hoverOpts(id ='mouse_hover', delay = 800)))
          ),
          fluidRow(
            column(width = 6,tableOutput("mtcars_tbl"))
          )
        )
      )
    )
  ))
)


