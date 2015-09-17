library(data.table)
library(plotrix)

shinyServer(function(input, output, session) {
  
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
  
  # This funtion will render the Vaping PowerCharts
  render_powercharts <- function(){
    B <- seq(3.2, 6.0, 0.1)
    A <- seq(1.4, 5.0, 0.1)
    C <- outer(B*B,A, '/')
    dt = as.data.table(C)
    dt2 = as.list(data.table(t(dt)))
    tbl <- as.data.frame(dt2)
    colnames(tbl) <- c(seq(3.2, 6.0, 0.1))
    rownames(tbl) <- seq(1.4, 5.0, 0.1)
    par(mar = c(4, 4, 4, 4))
    color2D.matplot(tbl, 
                    main = "Vaping Power Chart 1.0",
                    show.values = TRUE,
                    axes = FALSE,
                    xlab = "Voltage",
                    ylab = "Ohm",
                    vcex = 0.5,
                    vcol = "black",
                    extremes = c("white","lightgreen","green","lightyellow","yellow","pink","red"),
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
    if ( watt >= 2 & watt <3.4 ) {
      return <- "<b><font color=\"blue\">Power level maybe to low to produce a strong vapor</font></b>"
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
  
  output$plot <- renderPlot(render_powercharts())
  
  
  output$voltage <- renderText({
    paste0("Selected Voltage is: ", input$voltage)
  })
  
  output$ohms <- renderText({
    paste0("Selected Resistance (OHM) is: ", input$ohms)
  })
  
  output$watt <- renderText({
    paste0("Computed Watt is: ", print(signif(w(input$voltage,input$ohms) ), digits=2)   )
  })
  
  output$recommendation <- renderText({
    paste0(r(w(input$voltage,input$ohms)) )
  })
  
  output$color <- renderText({
    paste0(HTML(r(w(input$voltage,input$ohms))) )
  })
  
})