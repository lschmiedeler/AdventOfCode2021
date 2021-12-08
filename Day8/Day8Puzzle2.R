library(tidyverse)

input <- read.csv("Day8Input.txt", header = FALSE, sep = "|")
colnames(input) <- c("signal_patterns", "output_value")
input$signal_patterns <- as.character(input$signal_patterns)
input$output_value <- as.character(input$output_value)

#' 
#' digit   segments               number of segments
#' 1*            3,       6       2
#' 4*         2, 3, 4,    6       4
#' 7*      1,    3,       6       3
#' 8*      1, 2, 3, 4, 5, 6, 7    7
#' 
#' 
#' 2       1,    3, 4, 5,    7    5
#' 3       1,    3, 4,    6, 7    5
#' 5       1, 2,    4,    6, 7    5
#' 
#' 0       1, 2, 3,    5, 6, 7    6
#' 6       1, 2,    4, 5, 6, 7    6
#' 9       1, 2, 3, 4,    6, 7    6
#' 

#' 
#' find segments 3, 6 using digit 1
#' find segments 2, 4 by comparing digits 1, 4
#' 
#' number of segments = 5:
#'   digit 5 has segments 2, 4
#'   digit 2 is missing one of segments 3, 6
#'   
#' number of segments = 6:
#'   digit 0 is missing one of segments 2, 4
#'   digit 6 is missing one of segments 3, 6
#' 

digit_mat <- sapply(input[,1], function(x) {
  split <- strsplit(trimws(x), split = " ")[[1]]
  
  digits <- sort(sapply(split, function(y) {
    case_when(nchar(y) == 2 ~ 1, nchar(y) == 4 ~ 4,
              nchar(y) == 3 ~ 7, nchar(y) == 7 ~ 8,
              nchar(y) == 5 ~ -1, nchar(y) == 6 ~ -1)
  }), decreasing = TRUE)
  digits_2346 <- strsplit(names(digits)[3], split = "")[[1]]
  digits_36 <- strsplit(names(digits)[4], split = "")[[1]]
  digits_24 <- digits_2346[!(digits_2346 %in% digits_36)]
  
  digits <- sapply(split, function(y) {
    case_when(nchar(y) == 2 ~ 1, nchar(y) == 4 ~ 4,
              nchar(y) == 3 ~ 7, nchar(y) == 7 ~ 8,
              nchar(y) == 5 ~
                case_when(sum(digits_24 %in% strsplit(y, "")[[1]]) == 2 ~ 5,
                          sum(digits_36 %in% strsplit(y, "")[[1]]) == 1 ~ 2,
                          TRUE ~ 3),
              nchar(y) == 6 ~ 
                case_when(sum(digits_24 %in% strsplit(y, "")[[1]]) == 1 ~ 0,
                          sum(digits_36 %in% strsplit(y, "")[[1]]) == 1 ~ 6,
                          TRUE ~ 9))
  })
  
  return(names(sort(digits)))
})
colnames(digit_mat) <- NULL

output <- sapply(input[,2], function(x) {
  i <- which(input[,2] == x)
  split <- strsplit(trimws(x), split = " ")[[1]]
  sapply(split, function(y) {
    split_y <- strsplit(y, split = "")[[1]]
    for (j in 1:nrow(digit_mat)) {
      if (setequal(split_y, strsplit(digit_mat[j,i], split = "")[[1]])) {
        return(j - 1)
      }
    }
  })
})
colnames(output) <- NULL
rownames(output) <- NULL

sum(apply(output, MARGIN = 2, function(x) {
  as.numeric(paste(as.character(x), collapse = ""))
}))