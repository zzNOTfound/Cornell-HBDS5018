#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(medicaldata)
library(rsconnect)
library(tidyverse)
library(stringr)


shinyServer(function(input, output) {
  
  ## first plot (bar plot)
  output$p1 <- renderPlotly({
    
    ## filter the data by improvement
    strep_tb_1 <- strep_tb %>%
      filter(improved == input$improved) %>%
      mutate(study_arm = if_else(arm == "Control", "Placebo", "Streptomycin")) %>%
      mutate(rating_month6 = as.factor(rad_num)) %>%
      select(rating_month6, study_arm, improved)
    
    ## define the title of the plot based on selection
    if(input$improved == TRUE){
      title1 = "Chest X-Ray Rating of Improved Outcome by Study Arm"
    } else {
      title1 = "Chest X-Ray Rating of Not Improved Outcome by Study Arm"
    }
    
    ## create the bar plot
    plot1 <- ggplot(data = strep_tb_1, 
                    aes(x = rating_month6, 
                        fill = study_arm)) +
      geom_bar(position = "dodge") +
      labs(title = title1,
           x = "Numeric Rating of Chest X-Ray at Month 6",
           y = "Count",
           fill = "Study Arm")
   
    ggplotly(plot1)
  })
  
  
  ## second plot (scatterplot)
  output$p2 <- renderPlotly({
    
    ## rename and factor the data
    strep_tb_2 <- strep_tb %>%
      mutate(rating_month6 = as.factor(rad_num)) %>%
      mutate(gender = ifelse(gender == "M", "Male", "Female"))
    
    ## create the scatterplot with jitter
    plot2 <- ggplot(data = strep_tb_2,
                    aes(x = rating_month6,
                        y = strep_resistance,
                        col = input$gender)) + 
      geom_jitter() +
      labs(title = "Resistance VS. Rating of Chest X-Ray",
           x = "Numeric Rating of Chest X-ray at Month 6",
           y = "Resistance to Steptomycin at Month 6",
           col = "Gender")
    
    ggplotly(plot2)
  })
  
  
  ## third plot (scatterplot)
  output$p3 <- renderPlotly({
    
    ## rename and factor the data
    strep_tb_3 <- strep_tb %>%
      mutate(study_arm = if_else(arm == "Control", "Placebo", "Streptomycin")) %>%
      mutate(rating_month6 = as.factor(rad_num))
    
    ## create the scatterplot
    plot3 <- ggplot(data = strep_tb_3,
                    aes(x = rating_month6,
                        y = .data[[input$baseline]],
                        col = study_arm)) +
      geom_jitter() +
      labs(title = "Baseline Condition VS. Rating of Chest X-Ray",
           x = "Numeric Rating of Chest X-Ray at month 6",
           y = str_to_title(gsub("_", " ", input$baseline)),
           col = "Study Arm")
    
    ggplotly(plot3)
  })
})
