library(tidyverse)

input <- read.csv("Day3Input.txt", header = FALSE, sep = "", colClasses = c("character"))

df <- as.data.frame(do.call(rbind, strsplit(input[,1], split = "")),
                    stringsAsFactors = FALSE)
df <- apply(df, 2, function(x) as.integer(x))

gamma <- apply(df, 2, function(x) ifelse(sum(x) / length(x) >= 0.5, 1, 0))
epsilon <- apply(df, 2, function(x) ifelse(sum(x) / length(x) < 0.5, 1, 0))

df_oxygen <- as.data.frame(df)
for (i in 1:ncol(df_oxygen)) {
  if (nrow(df_oxygen) > 1) {
    value <- ifelse(sum(df_oxygen[,i]) / length(df_oxygen[,i]) >= 0.5, 1, 0)
    df_oxygen <- filter(df_oxygen, !!as.symbol(colnames(df_oxygen)[i]) == value)
  }
}
oxygen <- paste(df_oxygen, collapse = "")

df_co2 <- as.data.frame(df)
for (i in 1:ncol(df_co2)) {
  if (nrow(df_co2) > 1) {
    value <- ifelse(sum(df_co2[,i]) / length(df_co2[,i]) >= 0.5, 0, 1)
    df_co2 <- filter(df_co2, !!as.symbol(colnames(df_co2)[i]) == value)
  }
}
co2 <- paste(df_co2, collapse = "")

strtoi(oxygen, base = 2) * strtoi(co2, base = 2)