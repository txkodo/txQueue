# length += 1
scoreboard players add $main.len txqueue 1

# データをheadに設定
data modify storage txqueue:main data[-1][-1][-1][-1][-1][-1] set from storage txqueue: IO

# headを次の位置にずらす
function txqueue:core/main/enqueue/1
