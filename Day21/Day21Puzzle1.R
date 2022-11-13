die <- 1
die_rolls <- 0

pos_1 <- 7
pos_2 <- 8

score_1 <- 0
score_2 <- 0

while (T) {
  roll_1 <- 3 * die + 3
  die <- ifelse(die + 3 == 100, 100, (die + 3) %% 100)
  die_rolls <- die_rolls + 3
  pos_1 <- ifelse((pos_1 + roll_1) %% 10 == 0, 10, (pos_1 + roll_1) %% 10)
  score_1 <- score_1 + pos_1
  if (score_1 >= 1000) {
    print(score_2 * die_rolls)
    break
  }
  
  roll_2 <- 3 * die + 3
  die <- ifelse(die + 3 == 100, 100, (die + 3) %% 100)
  die_rolls <- die_rolls + 3
  pos_2 <- ifelse((pos_2 + roll_2) %% 10 == 0, 10, (pos_2 + roll_2) %% 10)
  score_2 <- score_2 + pos_2
  if (score_2 >= 1000) {
    print(score_1 * die_rolls)
    break
  }
}