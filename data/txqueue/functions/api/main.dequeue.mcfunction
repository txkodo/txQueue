# キューの末尾からアイテムを取得
# storage txqueue: IO に結果が入る
execute unless score $main.len txqueue matches -2147483648 run function txqueue:core/main/dequeue
