Class {
	#name : #MicroPythonCode,
	#superclass : #ScratchCode,
	#category : #'MicroWiz-MPython'
}

{ #category : #'code generator' }
MicroPythonCode >> argsOf: aMorph [
	^ aMorph blockArgs collect: [ :each | each argOf: parser ]
]

{ #category : #'control ops' }
MicroPythonCode >> doForeverBegin: aMorph [
	generator doForeverBegin
]

{ #category : #'control ops' }
MicroPythonCode >> doForeverEnd: aMorph [
	generator doForeverEnd
]

{ #category : #'control ops' }
MicroPythonCode >> doUntilBegin: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := generator doUntilBegin: cond.
	aMorph labelId: id
]

{ #category : #'control ops' }
MicroPythonCode >> doUntilEnd: aMorph [
	generator doUntilEnd: aMorph labelId
]

{ #category : #'control ops' }
MicroPythonCode >> doWhileBegin: aMorph [
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := generator doWhileBegin: cond.
	aMorph labelId: id
]

{ #category : #'control ops' }
MicroPythonCode >> doWhileEnd: aMorph [
	generator doWhileEnd: aMorph labelId
]

{ #category : #'arg generator' }
MicroPythonCode >> expressionArgWithMenuString: aMorph [ 
	| v |
	v := aMorph specialValue.
	v ifNil: [^ self argString: aMorph].
	aMorph ownerSelector = #append:toList:
		ifTrue: 
			[v = #all ifTrue: [^ ':'].
			v = #last ifTrue: [^ '-1']].
	aMorph ownerSelector = #setLine:ofList:to:
		ifTrue: 
			[v = #last ifTrue: [^ '-1']].
	^ v
]

{ #category : #private }
MicroPythonCode >> falseString [
	^ generator falseString
]

{ #category : #'code generator' }
MicroPythonCode >> generateCode: aSymbol morph: aMorph [
	self class addCommand: aSymbol.
	SpScratchApp
		try: [ self rawGenerateCode: aSymbol morph: aMorph ]
		onFailure: [ aMorph showBalloon: 'error' ]
]

{ #category : #'code generator' }
MicroPythonCode >> generateIndent: anInteger [
	generator indent: anInteger
]

{ #category : #'code generator' }
MicroPythonCode >> generatePass [
	generator generatePass
]

{ #category : #'code generator' }
MicroPythonCode >> generateReporter: aString [
	generator appendWithNewline: aString
]

{ #category : #'code generator' }
MicroPythonCode >> generateReporter: aSymbol morph: aMorph [
	| ret |
	self class addCommand: aSymbol.
	ret := 0.
	SpScratchApp
		try: [ ret := self rawGenerateCode: aSymbol morph: aMorph ]
		onFailure: [ aMorph showBalloon: 'error' ].
	^ ret
]

{ #category : #'code generator' }
MicroPythonCode >> generateSubHeader: aString [
	generator def: aString
]

{ #category : #'variable ops' }
MicroPythonCode >> getVar: var [
	^ generator getVar: var variable
]

{ #category : #accessing }
MicroPythonCode >> header [
	^ generator header
]

{ #category : #private }
MicroPythonCode >> indentLevelFor: aString [ 
	^ aString = 'startup' "'Scratch-StartClicked'"
		ifTrue: [0]
		ifFalse: [1]
]

{ #category : #accessing }
MicroPythonCode >> parse: aBlock withHeader: aBoolean [
	| code |
	code := self parse: aBlock.
	(code isEmpty or: [ aBoolean not ])
		ifTrue: [ ^ code ].
	^ self header , code
]

{ #category : #accessing }
MicroPythonCode >> parseHats: aCollection [
	| code |
	aCollection do: [ :each | each parseUsing: parser ].
	code := generator code.
	^ generator header , code
]

{ #category : #'code generator' }
MicroPythonCode >> rawGenerateCode: aSymbol morph: aMorph [
	| args |
	args := self argsOf: aMorph.
	(aSymbol beginsWith: 'ext')
		ifTrue: [ ^ generator
				generateExtCode: aSymbol asSymbol
				arguments: args
				for: aMorph script ].
	(aSymbol beginsWith: 'int')
		ifTrue: [ ^ generator
				generateIntCode: aSymbol asSymbol
				arguments: args
				for: aMorph script ].
	^ generator perform: aSymbol asSymbol withArguments: args
]

{ #category : #private }
MicroPythonCode >> variableArgString: aString [
	^ generator variableArgString: aString
]
