# length -= 1
execute store result storage txqueue:mine length int 1 run data get storage txqueue:mine length 0.999969482421875

# データをtailから取得
data modify storage txqueue:mine IO set from storage txqueue:mine data[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._

# tailを空に
data modify storage txqueue:mine data[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._[{-:1b}]._ set value {}

# tailを次の位置にずらす
function txqueue:core/mine/tail/1
