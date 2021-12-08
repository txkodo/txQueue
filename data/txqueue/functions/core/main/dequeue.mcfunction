# length -= 1
scoreboard players remove $main.len txqueue 1

# データをtailから取得
data modify storage txqueue: IO set from storage txqueue:main data[0][0][0][0][0][0]

# tailを次の位置にずらす
function txqueue:core/main/dequeue/1