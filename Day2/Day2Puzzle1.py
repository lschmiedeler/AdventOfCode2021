file = open("Day2Input.txt", "r")

lines = file.readlines()

horizontal_position = 0
depth = 0

for i in range(len(lines)):
    split = lines[i].split()
    direction = split[0]
    amount = int(split[1])
    if direction == "forward":
        horizontal_position = horizontal_position + amount
    elif direction == "down":
        depth = depth + amount
    elif direction == "up":
        depth = depth - amount

file.close()

print(horizontal_position * depth)
