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

def complete(l):
    started = []
    for c in l:
        if c in ["(", "[", "{", "<"]:
            started.append(c)
        elif c == ")":
            if started[-1] == "(":
                started.pop(-1)
        elif c == "]":
            if started[-1] == "[":
                started.pop(-1)
        elif c == "}":
            if started[-1] == "{":
                started.pop(-1)
        elif c == ">":
            if started[-1] == "<":
                started.pop(-1)
    score = 0
    started.reverse()
    for c in started:
        if c == "(":
            score = score * 5 + 1
        elif c == "[":
            score = score * 5 + 2
        elif c == "{":
            score = score * 5 + 3
        elif c == "<":
            score = score * 5 + 4
    return score

non_corrupted = []
for l in lines:
    score = find_corrupted(l)
    if isinstance(score, type(None)):
        non_corrupted.append(l)

scores = []
for l in non_corrupted:
    score = complete(l)
    scores.append(score)
print(sorted(scores)[len(scores) // 2])
