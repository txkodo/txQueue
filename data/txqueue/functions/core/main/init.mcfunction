data modify storage txqueue:main length set value 8192
data modify storage txqueue:main head set value [{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}}]
data modify storage txqueue:main tail set value [{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}},{_:{_:3b}}]
data modify storage txqueue:main value set value [{_:[]},{_:[]},{_:[]},{_:[]}]
data modify storage txqueue:main data[{_:[]}]._ set value [{_:[]},{_:[]},{_:[]},{_:[]}]
data modify storage txqueue:main data[{_:[]}]._[{_:[]}]._ set value [{_:[]},{_:[]},{_:[]},{_:[]}]
data modify storage txqueue:main data[{_:[]}]._[{_:[]}]._[{_:[]}]._ set value [{_:[]},{_:[]},{_:[]},{_:[]}]
data modify storage txqueue:main data[{_:[]}]._[{_:[]}]._[{_:[]}]._[{_:[]}]._ set value [{_:[]},{_:[]},{_:[]},{_:[]}]
data modify storage txqueue:main data[{_:[]}]._[{_:[]}]._[{_:[]}]._[{_:[]}]._[{_:[]}]._ set value [{_:{}},{_:{}},{_:{}},{_:{}}]

data modify storage txqueue:main data[0] merge value {+:1b,-:1b}
data modify storage txqueue:main data[0]._[0] merge value {+:1b,-:1b}
data modify storage txqueue:main data[0]._[0]._[0] merge value {+:1b,-:1b}
data modify storage txqueue:main data[0]._[0]._[0]._[0] merge value {+:1b,-:1b}
data modify storage txqueue:main data[0]._[0]._[0]._[0]._[0] merge value {+:1b,-:1b}
data modify storage txqueue:main data[0]._[0]._[0]._[0]._[0]._[0] merge value {+:1b,-:1b}
