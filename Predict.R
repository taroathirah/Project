load("hashBigram.RData")
load("hashTrigram.RData")
load("hashQuadgram.RData")

cleanInput <- function(input) {
  cleaned <- removePunctuation(removeNumbers(tolower(input)))
  cleaned
}

lastNwords <- function(input, n) {
  result <- tail(strsplit(input, " ")[[1]], n)
  result
}

# bigram prediction
predict2 <- function(input) {
  cleanedInput <- cleanInput(input)
  value <- lastNwords(cleanedInput, 1)
  hashBigram[[value]]
}

# trigram prediction
predict3 <- function(input) {
  cleanedInput <- cleanInput(input)
  value <- lastNwords(input, 2)
  value <- paste(value, sep="_", collapse="_")
  hashTrigram[[value]]
}

# quadgram prediction
predict4 <- function(input) {
  cleanedInput <- cleanInput(input)
  value <- lastNwords(cleanedInput, 3)
  value <- paste(value, sep="_", collapse="_")
  hashQuadgram[[value]]
}

# backoff strategy
predictBackoff <- function(input) {
  val <- predict4(input)
  if(is.null(val)) {
    val <- predict3(input)
    if(is.null(val)) {
      val <- predict2(input)
      if(is.null(val)) {
        val <- "the"
      }
    }
  }
  val
}
