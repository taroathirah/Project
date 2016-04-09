# ui.R

library(shiny)

shinyUI(navbarPage("Coursera Capstone Project - Text prediction",
                   tabPanel("Shiny Application",
                            headerPanel("Simple Text Prediction"),
                            sidebarPanel(
                                radioButtons("level", "N-Gram level:",
                                           c("Bigram" = "bingram",
                                             "Trigram" = "trigram",
                                             "Quadgram" = "quadgram",
                                             "All (backoff strategy)" = "all"),
                                           selected="all"),
                              br(),
                              p("Select which N-Gram or strategy you wish to test"),
                              p("Prediction may take some time. Please wait for it to be ready."),
                              p("When the word 'Prediction:' appears below the text box, you're good to go!"),
                              p("Thanks for using this app. Hope you enjoy using this shiny app")
                            ),
                            mainPanel(
                              h3("Text prediction tool"),
                              textInput("textInput", "Text Input"),
                              textOutput("textOutput")
                            )
                   ),
                   tabPanel("Documentation",
                            p("This Shiny is the final project for Coursera Capstone Data Science in which it will give prediction of words your enter."),
                            p("The application makes use of N-Gram data structures of size 2, 3, and 4. Using the previous 1, 2, or 3 words to predict the next one."),
                            p("A fallback strategy is used when 'All' is selected. It first tries the 4-gram, and if the result is empty, it tries the next lowest n-gram."),
                            p("The source of the corpus data can be found at "),
                            a("Data Link", href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"),
                            br(),
                            br(),
                            p("How it works?:-"),
                            tags$div(
                              tags$ul(
                                tags$li("1. Select which N-Gram you want to use from the rabio button."),
                                tags$li("2. Enter a string of words in the box and hit enter."),
                                tags$li("3. The prediction word will be shown under the input text box."),
                                tags$li("4. You can try other string of words and play with the N-Gram options. :)
                                        
                                        ")
                                
                                )
                            )
                   )
))