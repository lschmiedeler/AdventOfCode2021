library(csvread)

ages <- read.csv("Day6Input.txt", header = FALSE)
ages <- as.numeric(t(ages))

for (i in 1:128) {
  add <- rep(8, sum(ages == 0))
  ages <- ifelse(ages == 0, 6, ages - 1)
  ages <- c(ages, add)
}

unique_ages <- sort(unique(as.numeric(ages)))
num_fish <- sapply(unique_ages, function(x) {
  x <- c(x)
  for (i in 1:128) {
    add <- rep(8, sum(x == 0))
    x <- ifelse(x == 0, 6, x - 1)
    x <- c(x, add)
  }
  return(length(x))
})

table_ages <- as.numeric(as.matrix(table(ages)))

table_ages <- as.numeric(table_ages)
num_fish <- as.numeric(num_fish)

as.int64(num_fish * table_ages) # sum these values