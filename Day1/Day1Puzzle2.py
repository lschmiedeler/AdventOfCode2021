file = open("Day1Input.txt", "r")

lines = file.readlines()

num_larger = 0
prev_window_sum = 0

for i in range(len(lines)):
    if i == 2:
        prev_window_sum = int(lines[i]) + int(lines[i - 1]) + int(lines[i - 2])
    elif i > 2:
        current_window_sum = int(lines[i]) + int(lines[i - 1]) + int(lines[i - 2])
        if current_window_sum > prev_window_sum:
            num_larger = num_larger + 1
        prev_window_sum = current_window_sum

file.close()

print(num_larger)

