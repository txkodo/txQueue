# キューにアイテムを追加
# storage txqueue:mine IO にデータを入力

# length != 16383 (+ 16384) で実行
execute unless data storage txqueue:mine {length:32767} run function txqueue:core/mine/enqueue
