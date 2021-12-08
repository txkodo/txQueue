# キューにアイテムを追加
# storage txqueue: IO にデータを入力
execute unless score $main.len txqueue matches 2147483647 run function txqueue:core/main/enqueue
