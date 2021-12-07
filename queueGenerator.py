from pathlib import Path
from typing import Callable
import json
import re

path = Path()

def genQueue(name:str,order:int = 6):
  """
  新しいキューを生成する

  ----------
  name : str
      キューの名前 (半角英数と-_のみ)
  order : int < 16
      キューのサイズを指定 4 ** order のサイズのキューになる。( 6 の場合 4 ** 6 = 4096)
  """
  assert order < 16
  assert re.match('[a-z0-9_-]+',name)

  size = 4 ** order
  core = path / fr'data\txqueue\functions\core\{name}'
  core.mkdir(exist_ok=True)
  api = path / fr'data\txqueue\functions\api'
  tag = path / fr'data\txqueue\tags\functions'

  jsondata = json.loads((tag/'init.json').read_text(encoding='utf8'))
  initfuncs = set(jsondata['values'])
  initfuncs.add(f'txqueue:core/{name}/init')
  jsondata['values'] = list(initfuncs)
  (tag/'init.json').write_text(json.dumps(jsondata),encoding='utf8')

  api_enqueue =  f'''# キューにアイテムを追加
# storage txqueue:{name} IO にデータを入力

# length != {size-1} (+ {size}) で実行
execute unless data storage txqueue:{name} {{length:{ 2 * size -1 }}} run function txqueue:core/{name}/enqueue
'''
  (api/f'{name}.enqueue.mcfunction').write_text(api_enqueue,encoding='utf8')
  
  api_dequeue =  f'''# キューの末尾からアイテムを取得
# storage txqueue:{name} IO に結果が入る

# length != 0 (+ {size}) で実行
execute unless data storage txqueue:{name} {{length:{size}}} run function txqueue:core/{name}/dequeue
'''
  (api/f'{name}.dequeue.mcfunction').write_text(api_dequeue,encoding='utf8')

  tag_enqueue = f'''{{"values": ["txqueue:api/{name}.enqueue"]}}'''
  (tag/f'{name}.enqueue.json').write_text(tag_enqueue,encoding='utf8')
  tag_dequeue = f'''{{"values": ["txqueue:api/{name}.dequeue"]}}'''
  (tag/f'{name}.dequeue.json').write_text(tag_dequeue,encoding='utf8')

  crlf = '\n'
  core_init = f'''data modify storage txqueue:{name} length set value {size}
data modify storage txqueue:{name} head set value [{ ",".join(["{_:{_:3b}}"] * order) }]
data modify storage txqueue:{name} tail set value [{ ",".join(["{_:{_:3b}}"] * order) }]
{crlf.join( f"data modify storage txqueue:{name} data{'[{_:[]}]._' * i} set value [{{_:[]}},{{_:[]}},{{_:[]}},{{_:[]}}]" for i in range(order) )}
{crlf.join( f"data modify storage txqueue:{name} data[0]{'._[0]' * i} merge value {{+:1b,-:1b}}" for i in range(order) )}
'''
  (core/'init.mcfunction').write_text(core_init,encoding='utf8')

  increment_multiplier = 1 + 1 / (size - 0.25)
  core_enqueue = f'''# length += 1
execute store result storage txqueue:{name} length int 1 run data get storage txqueue:{name} length {increment_multiplier}

# データをheadに設定
data modify storage txqueue:{name} data{"[{+:1b}]._"*order} set from storage txqueue:{name} IO

# headを次の位置にずらす
function txqueue:core/{name}/head/1
'''
  (core/'enqueue.mcfunction').write_text(core_enqueue,encoding='utf8')

  decrement_multiplier = 1 - 1 / (2 * size)
  core_dequeue = f'''# length -= 1
execute store result storage txqueue:{name} length int 1 run data get storage txqueue:{name} length {decrement_multiplier}

# データをtailから取得
data modify storage txqueue:{name} IO set from storage txqueue:{name} data{"[{-:1b}]._"*order}

# tailを空に
data modify storage txqueue:{name} data{"[{-:1b}]._"*order} set value {{}}

# tailを次の位置にずらす
function txqueue:core/{name}/tail/1
'''
  (core/'dequeue.mcfunction').write_text(core_dequeue,encoding='utf8')

  enqueue = core/'head'
  dequeue = core/'tail'
  enqueue.mkdir(exist_ok=True)
  dequeue.mkdir(exist_ok=True)
  for i in range(order):
    j = order - i
    funcgen: Callable[[str,str],str] = lambda hs,sign: f'''### {hs}移動処理 {i + 1}桁目
{f"""
# 子要素のインデックスを3にリセット
data modify storage txqueue:{name} {hs}[{j}]._._ set value 3b
""" if i != 0 else ''}
# {hs} マーカーを削除
data remove storage txqueue:{name} value{(f"[{{{sign}:1b}}]._" * j)[:-1]}{sign}

{f"""# 繰り下がりフラグ txqueue: borrow
execute store success storage txqueue: borrow byte 1 if data storage txqueue:{name} {hs}[{j-1}]._{{_:0b}}

# 繰り下がらない場合{hs}の位置を一つ手前に
execute if data storage txqueue: {{borrow:0b}} store result storage txqueue:{name} {hs}[{j-1}]._._ byte 0.75 run data get storage txqueue:{name} {hs}[{j-1}]._._

# 繰り下がり処理
execute if data storage txqueue: {{borrow:1b}} run function txqueue:core/{name}/{hs}/{i + 1}
""" if i != order - 1 else f"""
# インデックスが0だった場合4にする
execute store success storage txqueue:{name} {hs}[0]._._ byte 4 if data storage txqueue:{name} {hs}[0]._{{_:0b}}

# {hs}の位置を一つ手前に
execute store result storage txqueue:{name} {hs}[0]._._ byte 0.75 run data get storage txqueue:{name} {hs}[0]._._
""" }
# 3
execute if data storage txqueue:{name} {hs}[{j-1}]._{{_:3b}} run data modify storage txqueue:{name} value{(f"[{{{sign}:1b}}]._" * (j - 1))}[3].{sign} set value 1b
# 2
execute if data storage txqueue:{name} {hs}[{j-1}]._{{_:2b}} run data modify storage txqueue:{name} value{(f"[{{{sign}:1b}}]._" * (j - 1))}[2].{sign} set value 1b
# 1
execute if data storage txqueue:{name} {hs}[{j-1}]._{{_:1b}} run data modify storage txqueue:{name} value{(f"[{{{sign}:1b}}]._" * (j - 1))}[1].{sign} set value 1b
# 0
execute if data storage txqueue:{name} {hs}[{j-1}]._{{_:0b}} run data modify storage txqueue:{name} value{(f"[{{{sign}:1b}}]._" * (j - 1))}[0].{sign} set value 1b
'''
    (enqueue/f'{i}.mcfunction').write_text(funcgen('head','+'),encoding='utf8')
    (dequeue/f'{i}.mcfunction').write_text(funcgen('tail','-'),encoding='utf8')

genQueue('mine',7)