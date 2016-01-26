library(data.table)
library(plotrix)

shinyServer(function(input, output, session) {
  
  Sys.setlocale('LC_ALL','C')
  options(digits=2)
  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.txt')
  
  
  # This observer adds an entry to the log file every time
  # input$n changes.
  obs <- observe({    
    cat(input$voltage, '\n', file = logfilename, append = TRUE)
  })
  
  
  render_battery_table <- function(){
    
    A <- read.csv("http://s3.amazonaws.com/csvpastebin/uploads/af1716160e317682bf/batteryperformance.csv", sep=",",
                  nrows = 100)
    A
  }
  
  # This funtion will render the Vaping PowerCharts
  render_powercharts <- function(){
    B <- seq(3.2, 7.1, 0.1)
    A <- seq(1.2, 5.1, 0.1)
    C <- outer(B*B,A, '/')
    dt = as.data.table(C)
    dt2 = as.list(data.table(t(dt)))
    tbl <- as.data.frame(dt2)
    colnames(tbl) <- c(seq(3.2, 7.1, 0.1))
    rownames(tbl) <- seq(1.2, 5.1, 0.1)
    par(mar = c(4, 4, 4, 4))
    color2D.matplot(tbl, 
                    main = "Vaping Power Chart 1.0",
                    show.values = TRUE,
                    axes = FALSE,
                    xlab = "Voltage",
                    ylab = "Ohm",
                    vcex = 0.5,
                    vcol = "black",
                    extremes = c("blue","lightgreen","green","lightyellow","yellow","magenta","pink","red"),
                    show.legend = FALSE)
    axis(3, at = seq_len(ncol(tbl)) - 0.5,
         labels = names(tbl), tick = FALSE, cex.axis = 0.6)
    axis(2, at = seq_len(nrow(tbl)) -0.5,
         labels = rev(rownames(tbl)), tick = FALSE, las = 1, cex.axis = 0.6)
  }
  
  w <- function(voltage,ohms) {
    result <- (voltage * voltage) / ohms
    return(result)
  }
  
  r <- function(watt) {
    if ( watt >= 2.0 & watt <3.8 ) {
      return <- "<font color=\"Blue\">[ LOW ] Power level maybe too low to produce a strong vapor</font>"
    }
    else if ( watt >= 3.8 & watt < 8.4 ) {
      return <- "<font color=\"Green\" >[ GOOD ] Best vapor and Cartomizer / Atomizer Performance , coil life is optimal </font>"
    }
    else if ( watt >= 8.4 & watt < 10 ) {
      return <- "<font color=\"Orange\">[ WARM ] Delicate juice start to burn , plenty of throat hit </font>"
    }
    else if ( watt >= 10 & watt < 11 ) {
      return <- "<font color=\"#FA5858\">[ HOT ] Some juice will burn , coil life is shorter </font>"
    }
    else if ( watt >= 11  ) {
      return <- "<font color=\"Red\">[ TOO HOT ] Danger ! Power may melt wire and coil will die </font>"
    }
  }
  
  
  
  # When the client ends the session, suspend the observer.
  # Otherwise, the observer could keep running after the client
  # ends the session.
  session$onSessionEnded(function() {
    obs$suspend()
    
    # Also clean up the log file for this example
    unlink(logfilename)
  })
  
  output$plot <- renderPlot(render_powercharts())

  output$battery <- renderTable(render_battery_table())

  output$voltage <- renderText({
    paste0("Selected Voltage is: ", input$voltage , " V ")
  })
  
  output$ohms <- renderText({
    paste0("Selected Resistance is: ", input$ohms , " Ohm ")
  })
  
  output$watt <- renderText({
    paste0("Computed Watt is: ", print(signif(w(input$voltage,input$ohms) ), digits=2) , " W "   )
  })
  
  output$recommendation <- renderText({
    paste0(r(w(input$voltage,input$ohms)) )
  })
  
  output$color <- renderText({
    paste0(HTML(r(w(input$voltage,input$ohms))) )
  })
  
})
