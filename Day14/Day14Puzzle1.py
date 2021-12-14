file = open("Day14Input.txt")
lines = file.readlines()
file.close()

template = lines[0].strip()
rules = {}
for line in lines[2:len(lines)]:
    split = line.split("->")
    rules.update({split[0].strip(): split[1].strip()})

def grow_polymer(n_steps, template):
    for n in range(n_steps):
        new = ""
        for i in range(len(template) - 1):
            pair = template[i] + template[i + 1]
            insert = rules[pair]
            if i == 0:
                new = new + pair[0] + insert + pair[1]
            else:
                new = new + insert + pair[1]
        template = new
    return(template)

polymer = grow_polymer(10, template)

counts = []
for e in set(polymer):
    counts.append(polymer.count(e))

print(max(counts) - min(counts))
