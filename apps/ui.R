library(shiny)
library(data.table)
library(plotrix)


shinyUI(fluidPage(
  titlePanel("Safety Power Settings & Recommender for Vaping Devices"),
  fluidRow(
    column(4, wellPanel(
      HTML('Notes : 3.7 Volts is the voltage used by most fixed power devices'),
      sliderInput("voltage", "Voltage:",
                  min = 3.2, max = 7.1, value = 3.9, step= 0.1),
      sliderInput("ohms", "Ohms:",
                  min = 1.2, max = 5.1, value = 3.0, step= 0.1),
      HTML('<p><img width=100% height=100% src="tank.png"/></p>'),
      HTML('Subtank Clearomizer Tank & Kanthall Coil'),
      HTML('<p><img width=100% height=100% src="mod.png"/></p>'),
      HTML('Box Mod'),
      HTML('<p><img width=100% height=100% src="eliquid.png"/></p>'),
      HTML('E-Liquid'),
      HTML('<p><img width=100% height=100% src="battery.png"/></p>'),
      HTML('18650 Battery')
    ))
    ,
    column(8,
           HTML('Formula for determine the Power in Watts - <b> W = (V x V) / R </b>'),
           br(),
           HTML('<b><u>Variables</u></b>'),
           br(),br(),
           HTML('<p><img width=32 height=25 src="volt.gif"/></p>'),
           verbatimTextOutput("voltage"),
           HTML('<p><img width=20 height=20 src="ohm.png"/></p>'),
           verbatimTextOutput("ohms"),
           HTML('<p><img width=30 height=30 src="watt.png"/></p>'),
           verbatimTextOutput("watt"),
           br(),
           HTML('<p><img width=25 height=25 src="out.png"/></p>'),
           HTML('<b><u>Recommendation</u></b>'),
           HTML('<table  style="background-color:#EDEDED"  style="width:0%"><tr><td>'),
           uiOutput("color"),
           HTML('</td></tr></table>'),
           br(),
           HTML('<p><img width=25 height=25 src="info.png"/></p>'),
           HTML('<b><u>Information</u></b>'),
           br(),
           tabsetPanel(
             tabPanel("Vaping Power Chart",plotOutput("plot")),
             tabPanel("Definitions and abbreviations",
                      HTML('<li>Vapor - a substance diffused or suspended in the air, especially one normally liquid or solid.</li>
                           <li>Mod - a modification of the electronic cigarette and most often refers to a modification of the battery that powers it.</li>
                           <li>Tank / SubTank -a container to hold the e-liquid</li>
                           <li>E-Liquid -is the fluid that fuels the Electronic Cigarette. It is what provides the nicotine solution and the flavoring to your Electronic Cigarette. It creates the vapor in which you exhale that mimics the traditional smoke from analogue cigarettes</li>
                           <li>18650 battery -Manufacturers produce the lithium ion 18650 battery at a size of 18 mm by 65 mm</li>
                           
                           '))
             ),
           HTML('<p align=left><a href="calculator.xlsx">Download Table</a><p>'),
           br(),
           HTML('<p><img width=45 height=25 src="batt.png"/></p>'),
           tabsetPanel(
             tabPanel("Power rating for rechargeable batteries",HTML(
           'The critical factor for ecig APV use is the C rating (discharge current) in amps. <br>
                                                                     The minimum possible value for safe and effective ecig use is 1 amp (= 1000mA) although ideally it needs to be higher. 
                                                                     <br><br>The ideal rating is 2.5 amps (2000mA) or better as a conventional atomizer usually draws 1A to 2.5A.
                                                                     <br><br>Below is the battery list and its rating :-<br><br>'),
           tabPanel("Battery",div(tableOutput("battery"), style = "font-size:80%")),
           HTML('<p align=left><a href="http://s3.amazonaws.com/csvpastebin/uploads/d019eb968e1393af1716160e317682bf/batteryperformance.csv">Download Battery Rating</a><p>'),
           HTML('Formula for Max drain rate in amps is C in <b> mAh / 1000 x C rating</b><br>'),
           br(),
           HTML('<b>Example: </b> an AW IMR Li-Mn 14500 battery has a capacity of 600mAh.<br> The C rating is 8C (it can supply a load of 8 times the capacity).<br>
                Therefore the max discharge current in amps is: 600 x 8 over 1000 (600 multiplied by 8 divided by 1000)<br>
                = 4800 / 1000<br>
                = 4.8 amps<br>'),
           br(),
           HTML('Formula for <b>Amp draw = voltage / resistance</b><br>'),
           br(),
           HTML('<b>Example: </b> a 5 volt APV is used with a 2.5 ohm atomizer - what current is drawn?<br>
                5 / 2.5 = 2<br>
                The battery must supply 2 amps.')),
             tabPanel("More Info",p("Resistance will also play a role in battery life. Current is what determines how 
             long your battery can be used. When you lower the resistance with the same Voltage, 
                                    you increase the current. Resistance is measured in Ohms, Energy is measured in Volts, 
                                    Power is measured in Watts, and Current(I) is measured in Amps."))
           ),
           br(),

                      
           br()
           
    )
  )
))