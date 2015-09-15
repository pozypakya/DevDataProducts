library(shiny)
shinyUI(fluidPage(
  titlePanel("Observer demo"),
  fluidRow(
    column(4, wellPanel(
      sliderInput("voltage", "Voltage:",
                  min = 3.2, max = 6.1, value = 4.5, step= 0.1),
      sliderInput("ohms", "Ohms:",
                  min = 3.2, max = 6.1, value = 4.5, step= 0.1)
    )),
    column(8,
           verbatimTextOutput("voltage"),
           verbatimTextOutput("ohms"),
           br(),
           br(),
           p("In this example, what's visible in the client isn't",
             "what's interesting. The server is writing to a log",
             "file each time the slider value changes.")
    )
  )
))