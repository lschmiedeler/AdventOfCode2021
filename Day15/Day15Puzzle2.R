library(raster)
library(tidyverse)
library(igraph)

input <- read.csv("Day15Input.txt", header = FALSE, colClasses = c("character"))
input <- t(apply(input, MARGIN = 1, function(x) {
  as.numeric(strsplit(x, split = "")[[1]])
}))

full_map <- matrix(nrow = nrow(input) * 5, ncol = ncol(input) * 5)
for (i in 1:5) {
  for (j in 1:5) {
    full_map[((i - 1) * nrow(input) + 1):(i * nrow(input)),
             ((j - 1) * nrow(input) + 1):(j * nrow(input))] <- input + (i - 1) + (j - 1)
  }
}
full_map[full_map > 9] <- full_map[full_map > 9] %% 9
input <- full_map

input_v <- as.vector(t(input))
n_cells <- length(input_v)
r <- raster(input)
adj <- as.data.frame(adjacent(r, cells = 1:n_cells))

adj <- adj %>% arrange(from) %>% mutate(weight = input_v[to])
g <- graph.data.frame(adj)
path <- as.vector(shortest_paths(g, from = 1, to = n_cells)$vpath[[1]])
print(sum(input_v[path]) - input[1])