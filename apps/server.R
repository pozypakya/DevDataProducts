shinyServer(function(input, output, session) {
  
  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.txt')
  
  
  # This observer adds an entry to the log file every time
  # input$n changes.
  obs <- observe({    
    cat(input$voltage, '\n', file = logfilename, append = TRUE)
  })
  
  w <- function(voltage,ohms) {
    result <- (voltage * voltage) / ohms
    return(result)
  }
  
  r <- function(watt) {
    if ( watt >= 2 & watt <3.4 ) {
      return <- "<b><font color=\"blue\">Power level maybe to low to produce a string vapor</font></b>"
    }
    else if ( watt >= 3.4 & watt <= 8.5 ) {
      return <- "<b><font color=\"green\" >Best vapor and Cartomizer / Atomizer Performance</font></b>"
    }
    else if ( watt > 8.5  ) {
      return <- "<b><font color=\"red\"> Danger ! Power may melt wire </font></b>"
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
  

  output$voltage <- renderText({
    paste0("The Voltage is: ", input$voltage)
  })
  
  output$ohms <- renderText({
    paste0("The Resistance is: ", input$ohms)
  })
  
  output$watt <- renderText({
    paste0("The Watt is: ", w(input$voltage,input$ohms)   )
  })
  
  output$recommendation <- renderText({
    paste0(r(w(input$voltage,input$ohms)) )
  })
  
  output$color <- renderText({
    paste0(HTML(r(w(input$voltage,input$ohms))) )
  })
  
})