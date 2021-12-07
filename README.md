# txQueue
データを移動しないキューを提供するライブラリ

## データをキューに追加
```
# 追加するデータを storage txqueue: ${name} IO に入れ
data modify storage txqueue: ${name} IO ...

# ファンクションを実行
function #txqueue:${name}.enqueue
```
※ ${name} はデフォルトだと main

## データをキューから取り出す
```
# ファンクションを実行
function #txqueue:${name}.dequeue

# 取り出されたデータが storage txqueue: ${name} IO に入る
data get storage txqueue: ${name} IO
```
※ ${name} はデフォルトだと main

# キューそのものを追加
デフォルトでは"main"という一つのキューのみが利用可能であるが、同梱されたpythonファイルを実行することで自由にキューを追加できる。
```Python
main.py

from .queueGenerator import genQueue

# デフォルトのmainキューの生成
genQueue('main',6)

# ユーザー定義キュー (foo) の生成
# 第一引数がキューの名称 [a-z0-9-_]+
# 第二引数がキューのサイズの指数 ( 4の第二引数乗がキューの最大要素数になる) 0 < x < 15
genQueue('foo',6)
```
