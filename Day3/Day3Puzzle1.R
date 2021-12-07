input <- read.csv("Day3Input.txt", header = FALSE, sep = "", colClasses = c("character"))

df <- as.data.frame(do.call(rbind, strsplit(input[,1], split = "")),
                    stringsAsFactors = FALSE)
df <- apply(df, 2, function(x) as.integer(x))

gamma <- paste(apply(df, 2, function(x) ifelse(sum(x) / length(x) > 0.5, 1, 0)),
               collapse = "")
epsilon <- paste(apply(df, 2, function(x) ifelse(sum(x) / length(x) < 0.5, 1, 0)),
                 collapse = "")

strtoi(gamma, base = 2) * strtoi(epsilon, base = 2)