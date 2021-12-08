# 初期化処理
scoreboard players set $main.len txqueue -2147483648
data modify storage txqueue:main template set value [[[[[[[[[{}]]]]]]]]]
data modify storage txqueue:main data set from storage txqueue:main template

#define score_holder $main.len
#define storage txqueue:main