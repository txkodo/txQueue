
### head移動処理 3桁目

# 子要素のインデックスを3にリセット
data modify storage txqueue:main head[4]._._ set value 3b

# head マーカーを削除
data remove storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}].+

# 繰り下がりフラグ txqueue: borrow
execute store success storage txqueue: borrow byte 1 if data storage txqueue:main head[3]._{_:0b}

# 繰り下がらない場合headの位置を一つ手前に
execute if data storage txqueue: {borrow:0b} store result storage txqueue:main head[3]._._ byte 0.9 run data get storage txqueue:main head[3]._._

# 繰り下がり処理
execute if data storage txqueue: {borrow:1b} run function txqueue:core/main/enqueue/4


# 3
execute if data storage txqueue:main head[3]._{_:2b} run data modify storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[3].+ set value 1b
# 2
execute if data storage txqueue:main head[3]._{_:2b} run data modify storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[2].+ set value 1b
# 1
execute if data storage txqueue:main head[3]._{_:2b} run data modify storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[1].+ set value 1b
# 0
execute if data storage txqueue:main head[3]._{_:2b} run data modify storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[0].+ set value 1b
