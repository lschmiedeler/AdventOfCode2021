input <- read.csv("Day8Input.txt", header = FALSE, sep = "|")
colnames(input) <- c("signal_patterns", "output_value")
input$signal_patterns <- as.character(input$signal_patterns)
input$output_value <- as.character(input$output_value)

sum(sapply(input[,2], function(x) {
  split <- strsplit(trimws(x), split = " ")[1]
  return(sum(sapply(split, function(y) {
    return(nchar(y) %in% c(2, 4, 3, 7))
  })))
}))