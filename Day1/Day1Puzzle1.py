file = open("Day1Input.txt", "r")

lines = file.readlines()

num_larger = 0
previous = 0

for i in range(len(lines)):
    if i == 0:
        previous = int(lines[i])
    else:
        current = int(lines[i])
        if current > previous:
            num_larger = num_larger + 1
        previous = current

file.close()

print(num_larger)
