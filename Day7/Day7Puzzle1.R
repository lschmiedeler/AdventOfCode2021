positions <- as.vector(read.csv("Day7Input.txt", header = FALSE)[1,])
unique_positions <- sort(unique(positions), decreasing = TRUE)

total_fuel <- sapply(unique_positions, function(x) {
  total_fuel <- sum(abs(positions - x))
  return(total_fuel)
})

print(min(total_fuel))