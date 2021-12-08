#> txqueue:api/main.enqueue
# @input storage txqueue: IO キューに追加するデータを入れる
# 
# キューにアイテムを追加
# 
# @api
execute store success storage txqueue: success byte 1 unless score $main.len txqueue matches 2147483647 run function txqueue:core/main/enqueue
