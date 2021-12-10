file = open("Day10Input.txt", "r")
lines = file.readlines()
file.close()

def find_corrupted(l):
    started = []
    for c in l:
        if c in ["(", "[", "{", "<"]:
            started.append(c)
        elif c == ")":
            if started[-1] == "(":
                started.pop(-1)
            else:
                return 3
        elif c == "]":
            if started[-1] == "[":
                started.pop(-1)
            else:
                return 57
        elif c == "}":
            if started[-1] == "{":
                started.pop(-1)
            else:
                return 1197
        elif c == ">":
            if started[-1] == "<":
                started.pop(-1)
            else:
                return 25137

total = 0
for l in lines:
    score = find_corrupted(l)
    if not isinstance(score, type(None)):
        total = total + int(score)
print(total)

