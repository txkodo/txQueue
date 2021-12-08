# txQueue
データの移動を抑えたキューを提供するライブラリ

最大格納数は4294967296

## データをキューに追加
```mcfunction
# 追加するデータを storage txqueue: IO に入れ
data modify storage txqueue: IO ...

# ファンクションを実行
function #txqueue:${name}.enqueue

# queueが満杯(4294967296要素)だった場合 storage txqueue: success が0bになる
```
※ ${name} はデフォルトだと main

## データをキューから取り出す
```mcfunction
# ファンクションを実行
function #txqueue:${name}.dequeue

# 取り出されたデータが storage txqueue: IO に入る
data get storage txqueue: IO

# queueが空だった場合 storage txqueue: success が0bになる
```
※ ${name} はデフォルトだと main

# キューそのものを追加
デフォルトでは"main"という一つのキューのみが利用可能であるが、同梱されたpythonファイルを実行することで自由にキューを追加できる。
```Python
main.py

from queueGenerator import genQueue

# デフォルトのmainキューの生成
genQueue('main')

# ユーザー定義キュー "foo" の生成
genQueue('foo')
```

## ライセンスについて
本データパックは MIT License を適用しています。
./LICENCE をご確認ください。

#### 連絡先
TwitterのDMにお願いします！
[Twitter@txkodo](https://twitter.com/txkodo)
