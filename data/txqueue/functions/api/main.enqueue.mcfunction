# キューにアイテムを追加
# storage txqueue: IO にデータを入力
execute store success storage txqueue: success byte 1 unless score $main.len txqueue matches 2147483647 run function txqueue:core/main/enqueue
