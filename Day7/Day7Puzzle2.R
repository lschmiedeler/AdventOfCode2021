positions <- as.vector(read.csv("Day7Input.txt", header = FALSE)[1,])

total_fuel <- sapply(min(positions):max(positions), function(x) {
  total_fuel <- abs(positions - x)
  total_fuel <- sum(total_fuel * (total_fuel + 1) / 2)
  return(total_fuel)
})

print(min(total_fuel))