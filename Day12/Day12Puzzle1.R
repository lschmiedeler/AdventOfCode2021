library(igraph)
library(tidyverse)

input <- read.csv("Day12Input.txt", header = FALSE, colClasses = c("character"))
input <- as.data.frame(t(apply(input, MARGIN = 1, function(x) {
  (strsplit(x, split = "-")[[1]])
})))
input <- filter(rbind(input, as.data.frame(t(apply(input, MARGIN = 1, function(x) {
  new_row <- c(x[2], x[1])
  names(new_row) <- c("V1", "V2")
  return(new_row)
})))), V1 != "end", V2 != "start")

all_nodes <- unique(as.vector(t(input)))
remove <- c()
for (node in all_nodes){
  if (node != "start" & node != "end" & node == tolower(node)) {
    to_nodes <- filter(input, V1 == node)$V2
    to_nodes <- to_nodes[!(to_nodes %in% c("start", "end"))]
    if (all(to_nodes == tolower(to_nodes))) {
      remove <- c(remove, node)
    }
  }
}

input <- filter(input, !(V1 %in% remove), !(V2 %in% remove))

# g <- graph(as.vector(t(input)), directed = FALSE)
# plot(g)

n_paths <<- 0
find_paths <- function(node, path) {
  path <- c(path, node)
  to_nodes <- filter(input, V1 == node)$V2
  if ("end" %in% to_nodes & to_nodes[length(to_nodes)] != "end") {
    i <- which(to_nodes == "end")
    to_nodes <- c(to_nodes[-i], to_nodes[i])
  }
  for (to in to_nodes) {
    if (to != "end") {
      if (!(to %in% path) | to == toupper(to)) {
        find_paths(to, path)
      }
    }
    else {
      path <- c()
      n_paths <<- n_paths + 1
      return(1)
    }
  }
}

find_paths("start", c())
print(n_paths)