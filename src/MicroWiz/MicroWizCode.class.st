Class {
	#name : #MicroWizCode,
	#superclass : #ScratchCode,
	#category : #'MicroWiz-Core'
}

{ #category : #'code generator' }
MicroWizCode >> argsOf: aMorph [
	^ aMorph blockArgs collect: [ :each | each argOf: parser ]
]

{ #category : #'control ops' }
MicroWizCode >> doForeverBegin: aMorph [
	generator doForeverBegin
]

{ #category : #'control ops' }
MicroWizCode >> doForeverEnd: aMorph [
	generator doForeverEnd
]

{ #category : #'control ops' }
MicroWizCode >> doIfBegin: aMorph [
	| cond |
	cond := aMorph blockArgs first argString: parser.
	generator doIfBegin: cond
]

{ #category : #'control ops' }
MicroWizCode >> doIfElseCenter: aMorph [
	generator doIfElse
]

{ #category : #'control ops' }
MicroWizCode >> doIfEnd: aMorph [
	generator doIfEnd
]

{ #category : #'control ops' }
MicroWizCode >> doRepeatBegin: aMorph [
	| num var |
	num := aMorph blockArgs first argString: parser.
	var := aMorph blockArgs second varName.
	generator doRepeatBegin: num var: var
]

{ #category : #'control ops' }
MicroWizCode >> doRepeatEnd: aMorph [
	generator doRepeatEnd
]

{ #category : #'control ops' }
MicroWizCode >> doUntilBegin: aMorph [
	| cond |
	cond := aMorph blockArgs first argString: parser.
	generator doUntilBegin: cond
]

{ #category : #'control ops' }
MicroWizCode >> doUntilEnd: aMorph [
	generator doUntilEnd
]

{ #category : #'control ops' }
MicroWizCode >> doWhileBegin: aMorph [
	| cond |
	cond := aMorph blockArgs first argString: parser.
	generator doWhileBegin: cond
]

{ #category : #'control ops' }
MicroWizCode >> doWhileEnd: aMorph [
	generator doWhileEnd
]

{ #category : #private }
MicroWizCode >> eventTitleString: aString [
	self shouldBeImplemented
]

{ #category : #'arg generator' }
MicroWizCode >> expressionArgWithMenuString: aMorph [ 
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
MicroWizCode >> falseString [
	^ generator falseString
]

{ #category : #'code generator' }
MicroWizCode >> generateCode: aSymbol morph: aMorph [
	self class addCommand: aSymbol.
	SpScratchApp
		try: [ self rawGenerateCode: aSymbol morph: aMorph ]
		onFailure: [ aMorph showBalloon: 'error' ]
]

{ #category : #'code generator' }
MicroWizCode >> generateGlobalVars: aCollection [
	generator generateGlobalVars: aCollection
]

{ #category : #'code generator' }
MicroWizCode >> generateIndent: anInteger [
	generator indent: anInteger
]

{ #category : #'code generator' }
MicroWizCode >> generatePass [
	generator generatePass
]

{ #category : #'code generator' }
MicroWizCode >> generateReporter: aString [
	generator appendWithNewline: aString
]

{ #category : #'code generator' }
MicroWizCode >> generateReporter: aSymbol morph: aMorph [
	| ret |
	self class addCommand: aSymbol.
	ret := 0.
	SpScratchApp
		try: [ ret := self rawGenerateCode: aSymbol morph: aMorph ]
		onFailure: [ aMorph showBalloon: 'error' ].
	^ ret
]

{ #category : #'code generator' }
MicroWizCode >> generateSubHeader: aString [
	generator def: aString
]

{ #category : #'variable ops' }
MicroWizCode >> getVar: var [
	^ generator getVar: var variable
]

{ #category : #accessing }
MicroWizCode >> header [
	^ generator header
]

{ #category : #private }
MicroWizCode >> indentLevelFor: aString [ 
	^ aString = 'startup' "'Scratch-StartClicked'"
		ifTrue: [0]
		ifFalse: [1]
]

{ #category : #private }
MicroWizCode >> localVarArgString: aString [
	^ generator localVarArgString: aString
]

{ #category : #accessing }
MicroWizCode >> parse: aBlock withHeader: aBoolean [
	| code |
	code := self parse: aBlock.
	(code isEmpty or: [ aBoolean not ])
		ifTrue: [ ^ code ].
	^ self header , code
]

{ #category : #accessing }
MicroWizCode >> parseHats: aCollection [
	| code |
	aCollection do: [ :each | each parseUsing: parser ].
	code := generator code.
	^ generator header , code
]

{ #category : #'code generator' }
MicroWizCode >> rawGenerateCode: aSymbol morph: aMorph [
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
	aSymbol = #getVar:
		ifTrue: [ ^ aMorph variable ].
	^ generator perform: aSymbol asSymbol withArguments: args
]

{ #category : #private }
MicroWizCode >> variableArgString: aString [
	^ generator variableArgString: aString
]
