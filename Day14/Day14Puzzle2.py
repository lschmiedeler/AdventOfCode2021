import copy

file = open("Day14Input.txt")
lines = file.readlines()
file.close()

template = lines[0].strip()

rules = {}
for line in lines[2:len(lines)]:
    split = line.split("->")
    rules.update({split[0].strip(): split[1].strip()})

letter_counts = {}
for e in set(template):
    letter_counts.update({e: template.count(e)})

pairs = []
for i in range(len(template) - 1):
    pairs.append(template[i] + template[i + 1])
pair_counts = {}
for p in set(pairs):
    pair_counts.update({p: pairs.count(p)})

def grow_polymer(n_steps, pair_counts):
    original_pair_counts = copy.deepcopy(pair_counts)
    if n_steps == 0:
        return
    else:
        for pair in original_pair_counts.keys():
            count = original_pair_counts[pair]
            insert = rules[pair]
            if insert in letter_counts.keys():
                letter_counts[insert] = letter_counts[insert] + count
            else:
                letter_counts.update({insert: count})
            pair_counts[pair] = pair_counts[pair] - count
            pair1 = pair[0] + insert
            if pair1 in pair_counts.keys():
                pair_counts[pair1] = pair_counts[pair1] + count
            else:
                pair_counts.update({pair1: count})
            pair2 = insert + pair[1]
            if pair2 in pair_counts.keys():
                pair_counts[pair2] = pair_counts[pair2] + count
            else:
                pair_counts.update({pair2: count})
        grow_polymer(n_steps - 1, pair_counts)
        
grow_polymer(40, pair_counts)

counts = letter_counts.values()
print(max(counts) - min(counts))
