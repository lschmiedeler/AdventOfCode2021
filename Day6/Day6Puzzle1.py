file = open("Day6Input.txt")

line = file.readlines()[0]

file.close()

ages = line.split(",")

for i in range(len(ages)):
    ages[i] = int(ages[i])

for i in range(1, 81):
    for j in range(len(ages)):
        if ages[j] > 0:
            ages[j] = ages[j] - 1
        elif ages[j] == 0:
            ages[j] = 6
            ages.append(8)

print(len(ages))
