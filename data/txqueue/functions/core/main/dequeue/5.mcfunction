### tail移動処理 5桁目

# 繰り上がりフラグ txqueue: borrow
execute store success storage txqueue: borrow byte 1 unless data storage txqueue:main data[0][0]

# 繰り上がらない場合tailを削除
execute if data storage txqueue: {borrow:0b} run data remove storage txqueue:main data[0][0]

# 繰り上がり処理
execute if data storage txqueue: {borrow:1b} run data remove storage txqueue:main data[0]