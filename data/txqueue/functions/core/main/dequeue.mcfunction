# length -= 1
execute store result storage txqueue:main length int 1 run data get storage txqueue:main length 0.99993896484375

# データをtailから取得
data modify storage txqueue:main IO set from storage txqueue:main value[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._

# tailを空に
data modify storage txqueue:main value[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._ set value {}

# tailを次の位置にずらす
function txqueue:core/main/dequeue/1
