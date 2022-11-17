#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

## Define UI
shinyUI(fluidPage(

    ## Application title
    titlePanel("Streptomycin for Tuberculosis Dataset Analysis"),
    
    ## dataset description section
    h4(strong(
      "Streptomycin for Tuberculosis Dataset Description"
    )),
    p(
      strong("Source: "),
      "This data set is from a prospective, randomized, placebo-controlled clinical trial, 
      Streptomycin Treatment of Pulmonary Tuberculosis published on October 30, 1948 
      in the British Medical Journal, pages 769-782, by the Streptomycin in Tuberculosis 
      Trials Committee. This is often considered the first modern randomized clinical trial 
      ever published."
    ),
    p(
      strong("Abstract: "),
      "This data set contains reconstructed records of 107 participants with pulmonary 
      tuberculosis. In 1948, collapse therapy (collapsing the lung by puncturing it with a needle) 
      and bedrest in sanitariums were the standard of care. This is the first modern report of 
      a randomized clinical trial. While patients on streptomycin often improved rapidly, 
      streptomycin resistance developed, and many participants relapsed. There was still 
      a significant difference in the death rate between the two arms. A similar effect 
      was seen with PAS, another new therapy for tuberculosis, and the authors rapidly 
      figured out that combination therapy was needed, which was tested in two subsequent 
      trials, which were published in 1952."
    ),
    p(
      strong("Citation(s): "),
      HTML(
        paste0(
          "The Streptomycin in Tuberculosis Trials Committee, ",
          em("Streptomycin Treatment of Pulmonary Tuberculosis"),
          ", British Medical Journal, October 30, 1948, pages 769-782, as found ",
          tags$a(href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2091872/pdf/brmedj03701-0007.pdf", 
                 "here", target="_blank"),
          "."
        )
      )
    ),
    p(
      strong("Codebook: "),
      HTML(
        paste0(
          "Codebook can be found ",
          tags$a(href="https://htmlpreview.github.io/?https://github.com/higgi13425/medicaldata/blob/master/man/codebooks/strep_tb_codebook.html", 
                 "here", target="_blank"),
          "."
        )
      )
    ),

    
    ## plots section
    h4(
      strong(
      "Plots and Plots Descriptions"
    )),
    
    ## create tab structure
    tabsetPanel(
      
      ## create first plot sidebar and include description of first plot
      tabPanel("Bar Plot", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(
                   radioButtons(
                     inputId = "improved",
                     label = "Patients outcomes of improved:",
                     choices = c("Improved" = "TRUE",
                                 "Not improved" = "FALSE")
                   ),
                   
                   helpText(
                     "The bar plot shows chest X-ray rating of different improvement 
                     outcome of tuberculosis status (measured by the numeric 
                     rating of chest X-ray at month 6), colored by the study arm  
                     that whether the patients takes streptomycin or placebo.
                     The selection of the status improved or not improved shows 
                     the bar plot by filtering the selection. It shows that whether 
                     streptomycin is effective to improve the tuberculosis status."
                   ),
                   helpText(
                     em(
                       "Numeric ratings of Chest X-ray at month 6:", br(), 
                       "1 = Death", br(),
                       "2 = Considerable Deterioration", br(),
                       "3 = Moderate Deterioration", br(),
                       "4 = No Change", br(),
                       "5 = Moderate Improvement", br(),
                       "6 = Considerable Improvement", br()
                     )
                   )
                   
                 ),
                 
                 ## first plot
                 mainPanel(
                   plotlyOutput("p1")
                 )
               )
      ),
      
      ## create second plot sidebar and include description of second plot
      tabPanel("Scatterplot1", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(
                   radioButtons(
                     inputId = "gender",
                     label = "Gender:",
                     choices = c("Male" = "Male",
                                 "Female" = "Female")
                   ),
                   
                   helpText(
                     "The scatterplot shows resistance to streptomycin versus 
                     rating of chest X-ray, colored by the selection of gender. 
                     It shows that if gender is a factor affecting the 
                     relationship between resistance to streptomycin and the 
                     chest X-ray rating."
                   ),
                   helpText(
                     em(
                       "Numeric ratings of Chest X-ray at month 6:", br(), 
                       "1 = Death", br(),
                       "2 = Considerable Deterioration", br(),
                       "3 = Moderate Deterioration", br(),
                       "4 = No Change", br(),
                       "5 = Moderate Improvement", br(),
                       "6 = Considerable Improvement", br()
                     )
                   )
                   
                 ),
                 
                 ## second plot
                 mainPanel(
                   plotlyOutput("p2")
                 )
               )
      ),
      
      ## create third plot sidebar and include description of third plot
      tabPanel("Scatterplot2", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(
                   selectInput(
                     inputId = "baseline",
                     label = "Baseline variables:",
                     choices = c("Condition of the Patient" = "baseline_condition",
                                 "Oral Temperature" = "baseline_temp",
                                 "Erythrocyte Sedimentation Rate" = "baseline_esr",
                                 "Cavitation of the Lungs on chest X-ray" = "baseline_cavitation")
                   ),
                   
                   helpText(
                     "The scatterplot shows difference baseline condition versus 
                     the rating of chest X-ray. It has four selection of the 
                     baseline condition:", br(),
                      em(
                        "Condition of the Patient: ", code("baseline_condition"), br(),
                        "Oral Temperature: ", code("baseline_temp"), br(),
                        "Erythrocyte Sedimentation Rate: ", code("baseline_esr"), br(),
                        "Cavitation of the Lungs on chest X-ray: ", code("baseline_cavitation")
                        ), br(),
                     "It shows that the relationship between the chest X-ray 
                     rating and baseline condition varies by the study arm."
                   ),
                   helpText(
                     em(
                       "Numeric ratings of Chest X-ray at month 6:", br(), 
                       "1 = Death", br(),
                       "2 = Considerable Deterioration", br(),
                       "3 = Moderate Deterioration", br(),
                       "4 = No Change", br(),
                       "5 = Moderate Improvement", br(),
                       "6 = Considerable Improvement", br()
                     )
                   )
                   
                 ),
                 
                 ## third plot
                 mainPanel(
                   plotlyOutput("p3")
                 )
               )
      )
    )
))
