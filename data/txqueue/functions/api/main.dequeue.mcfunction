# キューの末尾からアイテムを取得
# storage txqueue:main IO に結果が入る

# length != 0 (+ 8192) で実行
execute unless data storage txqueue:main {length:8192} run function txqueue:core/main/dequeue
