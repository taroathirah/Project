Cousera Capstone Data Scientist
========================================================
author: Siti Athirah Saharudin
date: 9 April 2016
autosize: true

## Introduction
This deck is solely for COursera DataScience Capstone Project in which students are required to build an application to predict words which based on Shiny Apps Library and later deployed on the RStudio Shiny Apps Server. The shiny application i made can be seen here >> https://taroathirah.shinyapps.io/DSCapstone/


Prediction Strategy
========================================================
The application will give prediction of the next word after you enter a string of words. Various prediction algorithms and data import strategies were explored.

* Text data from news, blogs, and twitter datasets were evaluated. The twitter data set was selected as representative of typical user input text.
* N-Gram data structures were used to collect groups of related words
* A strategy of using the more specific (higher order) N-Gram first, then backing down to the lower n grams was used. (Katz algorithm) 


Source of Data
===============================================

The source of the data used in this application is taken here >>> 
[Data Link](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)

- Various prediction algorithms and data import strategies were explored.
- Data have been imported, cleaned and summarized
- A hash table data structure was used to hold the final data for the application. This hashtable contains the predictor input text as the keys and provides the predicted word as the value.
- Hash tables for Bi-gram, Tri-gram, and Quad-gram structures were created which later users can choose which N-Gram they wanna use
- The data selected for this application is from the Twitter dataset of the project corpus.

What will the app do?
====================
Every word entered will determine the prediction of the next word based on the :- 

- Bigram:     
A hashtable derived from a TermDocumentMatrix with 2-word selections
- Trigram:     
A hashtable derived from a 3-element TermDocumentMatrix
- Quadgram:    
A hashtable derived from a 4-element TermDocumentMatrix
- Backoff strategy:   
A strategy in which the Quadgram is checked first, then the Trigram, then the Bigram


Finally..
====================
1. This simple application does not take semantic context into account. Additional filters on the input text could eliminate internal "noise" clauses and provide better prediction.

2. The limitations of the Shiny infrastructure prevented larger data structures from being deployed. An alternative server or implementation language may help to provide key-value looks for the additional news and blog text input samples.

3. Further filtering and compression may help the performance of the application.

4. Thank you for reading. Don't forget to try out my simple application. Thanks!
