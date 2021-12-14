conn <- file("Day13Input.txt", open = "r")
lines <-readLines(conn)
points <- data.frame()
folds <- data.frame()
for (line in lines) {
  if (line != "") {
    if (substr(line, 1, 1) != "f") {
      point <- as.numeric(strsplit(line, split = ",")[[1]])
      points <- rbind(points, point)
    }
    else {
      split <- strsplit(line, split = "=")[[1]]
      fold <- c(substr(split[1], nchar(split[1]), nchar(split[1])),
                as.numeric(split[2]))
      folds <- rbind(folds, fold)
    }
  }
}
names(points) <- c("x", "y")
names(folds) <- c("direction", "line")
close(conn)

direction <- folds[1,]$direction
line <- as.numeric(folds[1,]$line)
print(nrow(unique(t(apply(points, MARGIN = 1, function(x) {
  if (direction == "x") { i <- 1 }
  else {i <- 2}
  if (x[i] > line) {
    x[i] <- x[i] - 2 * abs(line - x[i])
  }
  return(x)
})))))