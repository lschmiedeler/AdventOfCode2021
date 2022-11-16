cubes_array <- array(rep(0, 101^3), dim = c(101, 101, 101))

myCon <- file(description = "Day22Input.txt", open = "r")
for (line in readLines(myCon)) {
  step <- strsplit(line, " ")
  on_or_off <- ifelse(step[[1]][1] == "on", 1, 0)

  cubes <- strsplit(step[[1]][2], ",")
  x <- as.integer(strsplit(strsplit(cubes[[1]][1], "=")[[1]][2], "\\.\\.")[[1]])
  y <- as.integer(strsplit(strsplit(cubes[[1]][2], "=")[[1]][2], "\\.\\.")[[1]])
  z <- as.integer(strsplit(strsplit(cubes[[1]][3], "=")[[1]][2], "\\.\\.")[[1]])

  if (sum(abs(x) <= 50) == 2 & sum(abs(y) <= 50) == 2 & sum(abs(z) <= 50) == 2) {
    x <- x + 51
    y <- y + 51
    z <- z + 51
    cubes_array[x[1]:x[2],y[1]:y[2],z[1]:z[2]] <- on_or_off
  }
}
close(myCon)

print(sum(cubes_array))