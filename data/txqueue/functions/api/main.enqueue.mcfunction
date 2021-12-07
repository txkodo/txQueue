# キューにアイテムを追加
# storage txqueue:main IO にデータを入力

# length != 8191 (+ 8192) で実行
execute unless data storage txqueue:main {length:16383} run function txqueue:core/main/enqueue
