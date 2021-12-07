file = open("Day2Input.txt", "r")

lines = file.readlines()

horizontal_position = 0
depth = 0
aim = 0

for i in range(len(lines)):
    split = lines[i].split()
    direction = split[0]
    amount = int(split[1])
    if direction == "forward":
        horizontal_position = horizontal_position + amount
        depth = depth + aim * amount
    elif direction == "down":
        aim = aim + amount
    elif direction == "up":
        aim = aim - amount

file.close()

print(horizontal_position * depth)
