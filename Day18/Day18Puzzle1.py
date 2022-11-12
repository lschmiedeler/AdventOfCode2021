import ast
import pandas as pd
import numpy as np

def create_depth_df(number, level):
    for element in number:
        if type(element) == list:
            create_depth_df(element, level + 1)
        else:
            values.append(element)
            depths.append(level)
    return pd.DataFrame({"value": values, "depth": depths})

def add(numbers_df_1, numbers_df_2):
    numbers_df = pd.concat([numbers_df_1, numbers_df_2])
    numbers_df["depth"] = numbers_df["depth"] + 1
    return numbers_df.reset_index(drop = True)

def explode(numbers_df):
    numbers_df = numbers_df.reset_index(drop = True)

    rows = numbers_df[numbers_df.depth == numbers_df.depth.max()].head(2).index
    row1 = rows[0]
    add1 = int(numbers_df.loc[row1,"value"])
    if row1 != 0:
        numbers_df.loc[row1-1,"value"] = add1 + int(numbers_df.loc[row1-1,"value"])

    row2 = rows[1]
    add2 = int(numbers_df.loc[row2,"value"])
    if row2 != len(numbers_df) - 1:
        numbers_df.loc[row2+1,"value"] = add2 + int(numbers_df.loc[row2+1,"value"])

    numbers_df.loc[row1,"value"] = 0
    numbers_df.loc[row1,"depth"] = 3
    
    numbers_df = numbers_df.drop(numbers_df.index[row2])
    return numbers_df.reset_index(drop = True)

def split(numbers_df):
    numbers_df = numbers_df.reset_index(drop = True)

    row = numbers_df.query("value >= 10").head(1).index[0]
    value = numbers_df.loc[row, "value"]
    round_down = value // 2 # left element of the pair
    round_up = value - value // 2 # right element of the pair

    numbers_df.loc[row,"depth"] = 1 + int(numbers_df.loc[row,"depth"])
    numbers_df.loc[row,"value"] = round_down

    before = numbers_df.loc[0:row,["value", "depth"]]
    before = before.append(pd.DataFrame({"value": [round_up], "depth": [int(numbers_df.loc[row,"depth"])]}))
    after = numbers_df.loc[(row+1):(len(numbers_df)-1),["value", "depth"]]
    numbers_df = before.append(after)

    return numbers_df.reset_index(drop = True)

def find_magnitude(numbers_df):
    numbers_df = numbers_df.reset_index(drop = True)

    while len(numbers_df) > 1:
        rows = numbers_df[numbers_df.depth == numbers_df.depth.max()].head(2).index
        numbers_df.loc[rows[0],"depth"] = numbers_df.loc[rows[0], "depth"] - 1
        numbers_df.loc[rows[0],"value"] = 3 * numbers_df.loc[rows[0], "value"] + 2 * numbers_df.loc[rows[1], "value"]
        numbers_df = numbers_df.drop(numbers_df.index[rows[1]])
        numbers_df = numbers_df.reset_index(drop = True)
    
    return numbers_df.loc[0,"value"]

def explode_all(numbers_df):
    continue_explode = True
    while continue_explode:
        if not numbers_df.query("depth >= 4").empty:
            numbers_df = explode(numbers_df)
        else:
            continue_explode = False
    return numbers_df.reset_index(drop = True)

file = open("Day18Input.txt")
lines = file.readlines()
file.close()

number_1 = lines[0]
number_1 = ast.literal_eval(number_1)
values = []
depths = []
numbers_df_1 = create_depth_df(number_1, 0)

for i in range(1, len(lines)):
    number_2 = lines[i]
    number_2 = ast.literal_eval(number_2)
    values = []
    depths = []
    numbers_df_2 = create_depth_df(number_2, 0)
    
    numbers_df_1 = add(numbers_df_1, numbers_df_2)
    
    continue_reduce = True
    while continue_reduce:
        if not numbers_df_1.query("depth >= 4").empty:
            numbers_df_1 = explode_all(numbers_df_1)
        elif not numbers_df_1.query("value >= 10").empty:
            numbers_df_1 = split(numbers_df_1)
        else:
            continue_reduce = False

print(find_magnitude(numbers_df_1))
