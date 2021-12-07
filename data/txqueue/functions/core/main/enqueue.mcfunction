# length += 1
execute store result storage txqueue:main length int 1 run data get storage txqueue:main length 1.000122074037904

# データをheadに設定
data modify storage txqueue:main value[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._[{+:1b}]._ set from storage txqueue:main IO

# headを次の位置にずらす
function txqueue:core/main/enqueue/1
