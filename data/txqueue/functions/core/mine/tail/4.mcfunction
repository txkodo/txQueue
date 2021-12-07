### tail移動処理 5桁目

# 子要素のインデックスを3にリセット
data modify storage txqueue:mine tail[3]._._ set value 3b

# tail マーカーを削除
data remove storage txqueue:mine value[{-:1b}]._[{-:1b}]._[{-:1b}].-

# 繰り下がりフラグ txqueue: borrow
execute store success storage txqueue: borrow byte 1 if data storage txqueue:mine tail[2]._{_:0b}

# 繰り下がらない場合tailの位置を一つ手前に
execute if data storage txqueue: {borrow:0b} store result storage txqueue:mine tail[2]._._ byte 0.75 run data get storage txqueue:mine tail[2]._._

# 繰り下がり処理
execute if data storage txqueue: {borrow:1b} run function txqueue:core/mine/tail/5

# 3
execute if data storage txqueue:mine tail[2]._{_:3b} run data modify storage txqueue:mine value[{-:1b}]._[{-:1b}]._[3].- set value 1b
# 2
execute if data storage txqueue:mine tail[2]._{_:2b} run data modify storage txqueue:mine value[{-:1b}]._[{-:1b}]._[2].- set value 1b
# 1
execute if data storage txqueue:mine tail[2]._{_:1b} run data modify storage txqueue:mine value[{-:1b}]._[{-:1b}]._[1].- set value 1b
# 0
execute if data storage txqueue:mine tail[2]._{_:0b} run data modify storage txqueue:mine value[{-:1b}]._[{-:1b}]._[0].- set value 1b
