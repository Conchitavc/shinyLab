library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)


Reload <<- 1
df <- mtcars
plot <- ggplot(mtcars,aes(x=wt,y=mpg)) + geom_point(alpha = 1,size = 3, color = "black",stroke = 0,xlab='wt',ylab = 'Millas por galon') +  ggtitle("GRAFICA DINAMICA")

    
shinyServer(function(input, output) {
    output$plot_click_options <- renderPlot({
        if (!is.null(input$clk)){
            Reload <<- 0
            puntos_sele <- nearPoints(mtcars, input$clk, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=puntos_sele,
                                    color = 'green',
                                    alpha = 1,
                                     size = 3)
        
        } else if (!is.null(input$dclk)){
            puntos_sele <- nearPoints(mtcars, input$dclk, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=puntos_sele,
                                       color = 'black',
                                       alpha = 1,
                                       size = 3)
            
        } else if (!is.null(input$mouse_brush)){
            puntos_sele <-  brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=puntos_sele,
                                       color = 'green',
                                       alpha = 1,
                                       size = 3)
        } else if (!is.null(input$mouse_hover)){
            puntos_sele <- nearPoints(mtcars, input$mouse_hover)
            plot <<- plot + geom_point(data=puntos_sele,
                                       color = 'gray',
                                       alpha = 1,
                                       size = 3)
        }
        else{
            plot
       }
        
    })


        output$mtcars_tbl <- renderTable({
            if (!is.null(input$mouse_brush)){
                df <<- brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
            } else if (!is.null(input$clk)){
                df <<- nearPoints(mtcars, input$clk, xvar = "wt", yvar = "mpg")
            } else if (Reload == 1 ){
                df <<- mtcars
            }
            df
        })
        

})
