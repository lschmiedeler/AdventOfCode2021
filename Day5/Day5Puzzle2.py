from collections import Counter
import numpy as np

file = open("Day5Input.txt", "r")

lines = file.readlines()
vents = []

for i in range(len(lines)):
    points = lines[i].split(" -> ")
    start = points[0].split(",")
    start_x = int(start[0])
    start_y = int(start[1])
    end = points[1].split(",")
    end_x = int(end[0])
    end_y = int(end[1])
    if start_x == end_x:
        vents.append((start_x, start_y))
        vents.append((end_x, end_y))
        if start_y == end_y:
            pass
        elif start_y > end_y:
            for y in range(end_y + 1, start_y):
                vents.append((start_x, y))
        elif start_y < end_y:
            for y in range(start_y + 1, end_y):
                vents.append((start_x, y))
    elif start_y == end_y:
        vents.append((start_x, start_y))
        vents.append((end_x, end_y))
        if start_x > end_x:
            for x in range(end_x + 1, start_x):
                vents.append((x, start_y))
        elif start_x < end_x:
            for x in range(start_x + 1, end_x):
                vents.append((x, start_y))
    else:
        vents.append((start_x, start_y))
        vents.append((end_x, end_y))
        if start_x > end_x:
            if start_y > end_y:
                for i in range(1, start_y - end_y):
                    vents.append((start_x - i, start_y - i))
            elif start_y < end_y:
                for i in range(1, end_y - start_y):
                    vents.append((start_x - i, start_y + i))
        elif start_x < end_x:
            if start_y > end_y:
                for i in range(1, start_y - end_y):
                    vents.append((start_x + i, start_y - i))
            elif start_y < end_y:
                for i in range(1, end_y - start_y):
                    vents.append((start_x + i, start_y + i))
        
file.close()

counts = np.asarray(list(Counter(vents).values()))
print(len((counts[counts > 1])))
