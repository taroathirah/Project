source("Predict.R")

input <- "## 12 quick"
output <-  predict2(input)

cat(sprintf("input: %s, output (Bigram): %s\n", input, output))

input <- "the quick"
output <- predict3(input)
cat(sprintf("input: %s, output (Trigram): %s\n", input, output))

input <- "the quick brown"
output <- predict4(input)
cat(sprintf("input: %s, output (Quadgram): %s\n", input, output))

input <- "a"
output <- predictBackoff(input)
cat(sprintf("input: %s, output (backoff): %s\n", input, output))