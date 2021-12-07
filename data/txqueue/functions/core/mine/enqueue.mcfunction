# length += 1
execute store result storage txqueue:mine length int 1 run data get storage txqueue:mine length 1.0000610360875868

# データをheadに設定
data modify storage txqueue:mine data[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._ set from storage txqueue:mine IO

# headを次の位置にずらす
function txqueue:core/mine/head/1
