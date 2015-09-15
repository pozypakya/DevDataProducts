library(shiny)
shinyUI(fluidPage(
  titlePanel("Safe Vaping Power Analyzer"),
  fluidRow(
    column(4, wellPanel(
      sliderInput("voltage", "Voltage:",
                  min = 3.2, max = 6.1, value = 3.9, step= 0.1),
      sliderInput("ohms", "Ohms:",
                  min = 1.4, max = 5.1, value = 3.0, step= 0.1)
    )),
    column(8,
           verbatimTextOutput("voltage"),
           verbatimTextOutput("ohms"),
           verbatimTextOutput("watt"),
           verbatimTextOutput("recommendation"),
           uiOutput("color"),
           br(),
           p("Resistance will also play a role in battery life. Current is what determines how 
             long your battery can be used. When you lower the resistance with the same Voltage, 
             you increase the current. Resistance is measured in Ohms, Energy is measured in Volts, 
             Power is measured in Watts, and Current(I) is measured in Amps.")
    )
  )
))