# キューからアイテムを取得
# storage txqueue: IO にデータが入る
execute store success storage txqueue: success byte 1 unless score $main.len txqueue matches -2147483648 run function txqueue:core/main/dequeue
