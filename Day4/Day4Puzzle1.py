from copy import deepcopy

file = open("Day4Input.txt", "r")

lines = file.readlines()

draw_numbers = []
board_number = -1
boards = []

for i in range(len(lines)):
    if i == 0:
        draw_numbers = lines[i].split(",")
        for j in range(len(draw_numbers)):
            draw_numbers[j] = int(draw_numbers[j])
    elif i % 6 == 1:
        board_number = board_number + 1
        boards.append([])
    elif i % 6 != 1:
        boards[board_number].append(lines[i])
    
file.close()

for i in range(len(boards)):
    full_board = ""
    for j in range(len(boards[i])):
        full_board = full_board + boards[i][j]
    boards[i] = full_board.split()
    for j in range(len(boards[i])):
        boards[i][j] = int(boards[i][j])

marked_boards = deepcopy(boards)

def check_bingo(marked_boards):
    for j in range(len(marked_boards)):
        for k in [0, 5, 10, 15, 20]:
            row = marked_boards[j][k:(k + 5)]
            if row.count("x") == 5:
                sum_unmarked = sum([marked_boards[j][l] for l, x in enumerate(marked_boards[j]) if x != "x"])
                return sum_unmarked
        for k in [0, 1, 2, 3, 4]:
            indices = [k, k + 5, k + 10, k + 15, k + 20]
            column = [marked_boards[j][l] for l in indices]
            if column.count("x") == 5:
                sum_unmarked = sum([marked_boards[j][l] for l, x in enumerate(marked_boards[j]) if x != "x"])
                return sum_unmarked
    return 0

for i in range(len(draw_numbers)):
    for j in range(len(marked_boards)):
        if draw_numbers[i] in marked_boards[j]:
            marked_boards[j][marked_boards[j].index(draw_numbers[i])] = "x"
    if i >= 5:
        if check_bingo(marked_boards) > 0:
            print(check_bingo(marked_boards) * draw_numbers[i])
            break
