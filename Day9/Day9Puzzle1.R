library(raster)
library(tidyverse)

input <- read.csv("Day9Input.txt", header = FALSE, colClasses = c("character"))
input <- as.data.frame(do.call(rbind, strsplit(input[,1], split = "")),
                       stringsAsFactors = FALSE)
input <- apply(input, 2, function(x) as.integer(x))
input_vector <- as.vector(t(input))

input_raster <- raster(input)
n_cells <- length(input_vector)
adjacent_df <- as.data.frame(adjacent(input_raster, cells = 1:n_cells, sorted = TRUE))

low_points <- adjacent_df %>%
  mutate(from_val = input_vector[from],
         to_val = input_vector[to],
         from_less_to = from_val < to_val) %>% 
  group_by(from) %>% summarize(n_less = sum(from_val < to_val),
                               n_total = n(),
                               low_point = n_less == n_total) %>%
  filter(low_point == TRUE)

sum(low_points %>% mutate(risk_level = input_vector[from] + 1) %>% select(risk_level))