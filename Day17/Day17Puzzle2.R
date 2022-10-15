library(tidyverse)

# define the target area
target_x <- 240:292
target_y <- -90:-57

# create a function that returns 1 if the initial velocity leads to 
# a target hit and 0 if the initial velocity leads to a target miss
take_steps <- function(v) {
  x <- v[1]
  y <- v[2]
  max_y <- y
  steps <<- data.frame(x = c(0, x), y = c(0, y))
  
  if (x %in% target_x & y %in% target_y) {
    return(1)
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
      return(1)
    }
    
    if (x > target_x[length(target_x)] | y < target_y[1]) {
      return(0)
    }
  }
}

# create a data frame of possible initial velocities
range <- 300
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
df_neg_y <- data.frame(x = df$x, y = -df$y)
df <- rbind(df, df_neg_y)
df_0 <- data.frame(x = 1:range, y = rep(0, range))
df <- rbind(df, df_0)
df <- arrange(df, by = x)

# create a new column in the data frame that is 1 if the velocity
# leads to a target miss and 0 if the velocity leads to a target miss
df$hit_target <- apply(X = df, MARGIN = 1, FUN = take_steps)
df$hit_target <- as.factor(df$hit_target)

# plot the points in the data frame
# plot if the velocities eventually result in a target hit (red) 
# or a target miss (black)
ggplot(df, aes(x = x, y = y, col = hit_target)) +
  geom_point() +
  scale_color_manual(values = c("black", "red")) +
  theme_minimal() +
  theme(legend.position = "none")

# find the number of initial velocities that result in a target hit
nrow(filter(df, hit_target == 1))