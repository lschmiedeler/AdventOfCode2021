library(raster)
library(tidyverse)
library(igraph)

input <- read.csv("Day15Input.txt", header = FALSE, colClasses = c("character"))
input <- t(apply(input, MARGIN = 1, function(x) {
  as.numeric(strsplit(x, split = "")[[1]])
}))

input_v <- as.vector(t(input))
n_cells <- length(input_v)
r <- raster(input)
adj <- as.data.frame(adjacent(r, cells = 1:n_cells))

adj <- adj %>% arrange(from) %>% mutate(weight = input_v[to])
g <- graph.data.frame(adj)
path <- as.vector(shortest_paths(g, from = 1, to = n_cells)$vpath[[1]])
print(sum(input_v[path]) - input_v[1])