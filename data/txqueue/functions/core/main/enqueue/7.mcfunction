### head移動処理 7桁目

# 繰り上がりフラグ txqueue: borrow
execute store success storage txqueue: borrow byte 1 if data storage txqueue:main data[-1][-1][3]

# 繰り上がらない場合headの位置を後にずらす
execute if data storage txqueue: {borrow:0b} run data modify storage txqueue:main data[-1][-1] append from storage txqueue:main template[-1][-1][-1]

# 繰り上がり処理
execute if data storage txqueue: {borrow:1b} run function txqueue:core/main/enqueue/8