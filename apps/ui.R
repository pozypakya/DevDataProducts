library(shiny)
library(data.table)
library(plotrix)

shinyUI(fluidPage(
  
  titlePanel("Safe Vaping Power Analyzer"),
  fluidRow(
    column(4, wellPanel(
      
      sliderInput("voltage", "Voltage:",
                  min = 3.2, max = 6.1, value = 3.9, step= 0.1),
      sliderInput("ohms", "Ohms:",
                  min = 1.4, max = 5.1, value = 3.0, step= 0.1),
      HTML('<p><img width=100% height=100% src="tank.png"/></p>'),
      HTML('Subtank Clearomizer Tank'),
      HTML('<p><img width=100% height=100% src="mod.png"/></p>'),
      HTML('Box Mod'),
      HTML('<p><img width=100% height=100% src="eliquid.png"/></p>'),
      HTML('E-Liquid')
    ))
    ,
    column(8,
           HTML('<b><u>Variables</u></b>'),
           verbatimTextOutput("voltage"),
           verbatimTextOutput("ohms"),
           verbatimTextOutput("watt"),
           br(),
           HTML('<b><u>Recommendation</u></b>'),
           uiOutput("color"),
           br(),
           HTML('<b><u>Vaping Power Chart</u></b>'),
           br(),
           tabPanel("Plot",plotOutput("plot")),
           HTML('<p align=right><a href="calculator.xlsx">Download Table</a><p>'),
           br(),
           
           HTML('<b><u>Information</u></b>'),
           p("Resistance will also play a role in battery life. Current is what determines how 
             long your battery can be used. When you lower the resistance with the same Voltage, 
             you increase the current. Resistance is measured in Ohms, Energy is measured in Volts, 
             Power is measured in Watts, and Current(I) is measured in Amps."),
           HTML('<b><u>Definitions and abbreviations</u></b>'),
           HTML('<li>Vapor - a substance diffused or suspended in the air, especially one normally liquid or solid.</li>
                 <li>Mod - a modification of the electronic cigarette and most often refers to a modification of the battery that powers it.</li>
                 <li>Tank / SubTank -a container to hold the e-liquid</li>
                 <li>E-Liquid -is the fluid that fuels the Electronic Cigarette. It is what provides the nicotine solution and the flavoring to your Electronic Cigarette. It creates the vapor in which you exhale that mimics the traditional smoke from analogue cigarettes</li>

                ')
           
    )
  )
))