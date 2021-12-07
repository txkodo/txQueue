### tail移動処理 10桁目

# 子要素のインデックスを3にリセット
data modify storage txqueue:mine tail[1]._._ set value 3b

# tail マーカーを削除
data remove storage txqueue:mine value[{-:1b}].-


# インデックスが0だった場合4にする
execute store success storage txqueue:mine tail[0]._._ byte 4 if data storage txqueue:mine tail[0]._{_:0b}

# tailの位置を一つ手前に
execute store result storage txqueue:mine tail[0]._._ byte 0.75 run data get storage txqueue:mine tail[0]._._

# 3
execute if data storage txqueue:mine tail[0]._{_:3b} run data modify storage txqueue:mine value[3].- set value 1b
# 2
execute if data storage txqueue:mine tail[0]._{_:2b} run data modify storage txqueue:mine value[2].- set value 1b
# 1
execute if data storage txqueue:mine tail[0]._{_:1b} run data modify storage txqueue:mine value[1].- set value 1b
# 0
execute if data storage txqueue:mine tail[0]._{_:0b} run data modify storage txqueue:mine value[0].- set value 1b
