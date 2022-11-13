library(stringr)

alg <- ""
more_alg <- T
image <- list()
myCon <- file(description = "Day20Input.txt", open = "r")
for (line in readLines(myCon)) {
  if (more_alg) { 
    alg <- alg <- paste0(alg, line) 
  }
  else {
    image <- c(image, strsplit(line, split = ""))
  }
  
  if (line == "") {
    more_alg <- F
  }
}
close(myCon)

image_mat <- matrix(t(as.data.frame(image)),
                    ncol = length(image[[1]]), nrow = length(image))

enhance <- function(image_mat) {
  image_mat_enhance <- image_mat
  for (i in 1:nrow(image_mat)) {
    for (j in 1:ncol(image_mat)) {
      grid <- matrix(nrow = 3, ncol = 3)
      grid[2,2] <- image_mat[i,j]
      for (k in 1:3) {
        for (l in 1:3) {
          tryCatch({
            grid[k,l] <- image_mat[i + (k - 2), j + (l - 2)]
          },
          error = function(e) {}
          )
        }
      }
      grid[is.na(grid)] <- "."
      
      str <- paste0(matrix(t(grid), nrow = 1), collapse = "")
      str_binary <- str_replace_all(str, "#", "1")
      str_binary <- str_replace_all(str_binary, "\\.", "0")
      dec_num <- strtoi(str_binary, base = 2)
      new <- substr(alg, dec_num + 1, dec_num + 1)
      image_mat_enhance[i,j] <- new
    }
  }
  return(image_mat_enhance)
}

# add border of "." around image
for (i in 1:10) {
  image_mat <- rbind(rep(".", ncol(image_mat)),
                     image_mat, rep(".", ncol(image_mat)))
  image_mat <- cbind(rep(".", nrow(image_mat)),
                     image_mat, rep(".", nrow(image_mat)))
}

image_mat <- enhance(enhance(image_mat))

# remove border of "#" around image
image_mat <- image_mat[-1,]
image_mat <- image_mat[,-1]
  
length(image_mat[image_mat == "#"])
