library(tidyverse)

# define the target area
target_x <- 240:292
target_y <- -90:-57

# create a function that returns the maximum y value achieved given 
# an initial velocity
take_steps <- function(v) {
  x <- v[1]
  y <- v[2]
  max_y <- y
  steps <<- data.frame(x = c(0, x), y = c(0, y))
  
  if (x %in% target_x & y %in% target_y) {
    return(max_y)
  }
  
  while(TRUE) {
    x0 <- x
    y0 <- y
    x <- x + v[1]
    y <- y + v[2] - 1

    if (x > 0) {
      x <- x - 1
    }
    if (x < 0) {
      x <- x + 1
    }
    if (x < x0) {
      x <- x0
    }
    
    steps <<- rbind(steps, data.frame(x = x, y = y))
    v <- c(x - x0, y - y0)
    
    if (y > max_y) {
      max_y <- y
    }
    
    if (x %in% target_x & y %in% target_y) {
      return(max_y)
    }
    
    if (x > target_x[length(target_x)] | y < target_y[1]) {
      return(0)
    }
  }
}

# create a data frame of possible initial velocities
range <- 100
xs <- c()
ys <- c()
for (i in 1:range) {
  xs <- c(xs, i:range)
  ys <- c(ys, rep(i, times = range - i + 1))
}
df <- data.frame(x = c(xs, ys), y = c(ys, xs))
non_dup <- df %>% filter(x != y)
dup <- (df %>% filter(x == y))[1:range,]
df <- rbind(non_dup, dup)
df <- arrange(df, by = x)

# create a new column in the data frame with the maximum y values
df$max_y <- apply(X = df, MARGIN = 1, FUN = take_steps)

# find the initial velocity that leads to the maximum y value
best <- filter(df, max_y == max(max_y))[1,]
best_x <- best$x
best_y <- best$y
v <- c(best_x, best_y)
max_y <- take_steps(v)
steps$max_y <- steps$y == max_y

# plot the points in the data frame
# plot their corresponding maximum y values using color
ggplot(df, aes(x = x, y = y, col = max_y)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()

# plot the origin (0,0) and the target rectangle
# plot the steps for the velocity that leads to the maximum y value
ggplot() +
  geom_rect(mapping = aes(xmin = target_x[1],
                          xmax = target_x[length(target_x)],
                          ymin = target_y[1],
                          ymax = target_y[length(target_y)],),
            fill = "red", color = "red", alpha = 0.5) +
  geom_point(data = steps, aes(x = x, y = y, col = max_y), size = 2) +
  scale_color_manual(values = c("black", "blue")) +
  theme_minimal() +
  theme(legend.position = "none")

# find the maximum y value
filter(df, max_y == max(max_y))$max_y[1]