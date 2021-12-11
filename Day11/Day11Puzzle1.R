library(raster)
library(tidyverse)

input <- read.csv("Day11Input.txt", header = FALSE, colClasses = c("character"))
input <- apply(input, MARGIN = 1, function(x) {
  as.numeric(strsplit(x, split = "")[[1]])
})

r <- raster(input)
n_cells <- nrow(input) * ncol(input)
adjacent <- as.data.frame(adjacent(r, cells = 1:n_cells, sorted = TRUE, directions = 8))

input_vector <- as.vector(input)

perform_steps <- function(input_vector, n_steps) {
  total_flashes <- 0
  for (step in 1:n_steps) {
    input_vector <- input_vector + 1
    flash <- input_vector > 9
    if (sum(flash) > 0) {
      continue <- TRUE
    }
    else {
      continue <- FALSE
    }
    all_flash_i <- c()
    while (continue) {
      flash_i <- setdiff(which(flash), all_flash_i)
      all_flash_i <- c(all_flash_i, flash_i)
      for (i in 1:length(flash_i)) {
        flash_to <- setdiff(filter(adjacent, from == flash_i[i])$to, all_flash_i)
        input_vector[flash_to] <- input_vector[flash_to] + 1
      }
      flash <- input_vector > 9
      if (sum(flash[-all_flash_i]) == 0) {
        continue <- FALSE
      }
    }
    input_vector[all_flash_i] <- 0
    total_flashes <- total_flashes + length(all_flash_i)
  }
  return(total_flashes)
}

perform_steps(input_vector, 100)