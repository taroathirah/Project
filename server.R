library(shiny)
suppressWarnings(library(tm))

suppressWarnings(library(RWeka))
suppressWarnings(library(stringi))
suppressWarnings(library(stringr))
suppressWarnings(library(hash))


#cat("loading prediction hashtables")
source("Predict.R")
#cat("..loaded.")

predict <- function(text, level) {
  text <- str_trim(text)
  if (is.null(text) || (str_length(text) == 0)) {
    # assume 'the' to start with
    'the'
  } else if ((length(level) == 0) || (level == "all")) {
    predictBackoff(text)
  } else if (level == 'bigram') {
    predict2(text)
  } else if (level == 'trigram') {
    predict3(text)
  } else if (level == 'quadgram') {
    predict4(text)
  } else {
    'the'
  }
} 

shinyServer(
  
  function(input, output) {
    #selection <- reactive({input$level})
    output$textOutput <- renderText({paste("Prediction: ", predict(input$textInput, str(input$level)))})
  }
)