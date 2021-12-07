# キューの末尾からアイテムを取得
# storage txqueue:mine IO に結果が入る

# length != 0 (+ 16384) で実行
execute unless data storage txqueue:mine {length:16384} run function txqueue:core/mine/dequeue
