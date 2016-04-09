suppressWarnings(library(tm))

options( java.parameters = "-Xmx6g" )
suppressWarnings(library(RWeka))

suppressWarnings(library(stringi))
suppressWarnings(library(stringr))
suppressWarnings(library(hash))


blogfile = file("./data/final/en_US/en_US.blogs.txt", "rb")
newsfile = file("./data/final/en_US/en_US.news.txt", "rb")
twitterfile = file("./data/final/en_US/en_US.twitter.txt", "rb")

dataSource <- DirSource(directory = "data/final/en_US",
                        pattern = "en_US.twitter.txt",
                        encoding = "utf-8")



corpus <- Corpus(dataSource)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
#corpus <- tm_map(corpus, stripWhitespace)

# work around the issue with parallel:mclapply 
options(mc.cores=1)

#UnigramTokenizer  <- function(x) RWeka::NGramTokenizer(x, RWeka::Weka_control(min=1, max=1))
BigramTokenizer   <- function(x) RWeka::NGramTokenizer(x, RWeka::Weka_control(min=2, max=2))
TrigramTokenizer  <- function(x) RWeka::NGramTokenizer(x, RWeka::Weka_control(min=3, max=3))
QuadgramTokenizer <- function(x) RWeka::NGramTokenizer(x, RWeka::Weka_control(min=4, max=4))

#dtm1 <- TermDocumentMatrix(corpus, control = list(tokenize = UnigramTokenizer))
tdm2 <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))
tdm3 <- TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))
tdm4 <- TermDocumentMatrix(corpus, control = list(tokenize = QuadgramTokenizer))

# save a checkpoint
save(tdm2, file="tdm2.RData")
save(tdm3, file="tdm3.RData")
save(tdm4, file="tdm4.RData")

tdmToDf <- function(tdm)  {
  #cat("inspect\n")
  df <- as.data.frame(inspect(tdm))
  #cat("made df\n")
  df$count <- rowSums(df)
  #cat("counted rows\n")
  # only interested in counts greater than 1
  df <- subset(df, count > 1)
  #cat("subset1\n")
  df[c('input', 'prediction')] <- subset(str_match(row.names(df), "(.*) ([^ ]*)"),  select = c(2,3))
  #cat("subset2\n")
  df <- subset(df, select=c('input', 'prediction', 'count'))
  #cat("subset3\n")
  df <- df[order(df$input, -df$count),]
  #cat("sort\n")
  row.names(df) <- NULL
  df
}

toHash <- function(df) {
  h <- hash()
  idx <- rev(seq(nrow(df)))
  for (i in idx) {
    key <- df[i, 'input']
    key <- gsub(" ", "_", key)
    val <- df[i, 'prediction']
    h[[key]] <- val
  }
  h
}

load("tdm2.RData")
dfBigram   <- tdmToDf(tdm2)
save(dfBigram, file="dfBigram.RData")
cat("saved Bigram")
hashBigram  <- toHash(dfBigram)
save(hashBigram,   file="hashBigram.RData")
cat("saved hashBigram")

load("tdm3.RData")
dfTrigram  <- tdmToDf(tdm3)
save(dfTrigram, file="dfTrigram.RData")
cat("saved trigram")
hashTrigram  <- toHash(dfTrigram)
save(hashTrigram,  file="hashTrigram.RData")

load("tdm4.RData")
dfQuadgram <- tdmToDf(tdm4)
save(dfQuadgram, file="dfQuadgram.RData")
hashQuadgram <- toHash(dfQuadgram)
save(hashQuadgram, file="hashQuadgram.RData")
