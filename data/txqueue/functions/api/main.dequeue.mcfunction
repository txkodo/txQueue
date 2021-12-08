#> txqueue:api/main.dequeue
# @output storage txqueue: IO キューから取り出されたデータが入る
# 
# キューからアイテムを取得
# 
# @api
execute store success storage txqueue: success byte 1 unless score $main.len txqueue matches -2147483648 run function txqueue:core/main/dequeue
