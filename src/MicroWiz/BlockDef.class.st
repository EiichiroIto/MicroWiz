Class {
	#name : #BlockDef,
	#superclass : #MicroWizBlockDef,
	#instVars : [
		'block',
		'code',
		'defaultArgs',
		'imports',
		'return',
		'selector',
		'id'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
BlockDef >> argPermutation [
	| parsedSpec parsedTranslatedSpec parsedSpecArgs parsedTranslatedSpecArgs |
	parsedSpec := CommandBlockMorph parseCommandSpec: block.
	parsedSpecArgs := parsedSpec
		select: [ :s | CommandBlockMorph isArgSpec: s ].
	parsedTranslatedSpec := CommandBlockMorph parseCommandSpec: code.
	parsedTranslatedSpecArgs := parsedTranslatedSpec
		select: [ :s | CommandBlockMorph isArgSpec: s ].
	parsedSpecArgs = parsedTranslatedSpecArgs
		ifTrue: [ ^ (1 to: parsedSpecArgs size) asArray ].
	^ parsedTranslatedSpecArgs
		collect: [ :each | self findPos: each in: parsedSpecArgs ]
]

{ #category : #accessing }
BlockDef >> block [
	^ block
]

{ #category : #accessing }
BlockDef >> block: anObject [
	block := anObject
]

{ #category : #api }
BlockDef >> blockTuple [
	^ {self block.
	self return.
	self selector} , self defaultArgs
]

{ #category : #accessing }
BlockDef >> code [
	^ code
]

{ #category : #accessing }
BlockDef >> code: anObject [
	code := anObject
]

{ #category : #api }
BlockDef >> codeWithArgs: aCollection [
	| args r w c i |
	args := self evaluatedArgs: aCollection.
	r := ReadStream on: self code.
	w := WriteStream on: String new.
	i := 1.
	[ r atEnd ]
		whileFalse: [ c := r next.
			c = $%
				ifTrue: [ w nextPutAll: (args at: i).
					i := i + 1.
					r next.
					[ r atEnd or: [ r peek isDigit not ] ] whileFalse: [ r next ] ]
				ifFalse: [ w nextPut: c ] ].
	^ w contents
]

{ #category : #accessing }
BlockDef >> defaultArgs [
	^ defaultArgs ifNil: [ #() ]
]

{ #category : #accessing }
BlockDef >> defaultArgs: anObject [
	defaultArgs := anObject
]

{ #category : #private }
BlockDef >> evaluatedArgs: aCollection [
	| args argPermutation |
	args := aCollection collect: [ :each | self valueOf: each ].
	argPermutation := self argPermutation.
	^ argPermutation collect: [ :each | args at: each ]
]

{ #category : #private }
BlockDef >> findPos: aString in: aCollection [
	| pos arg count |
	pos := aCollection indexOf: aString.
	pos > 0
		ifTrue: [ ^ pos ].
	aString last isDigit
		ifFalse: [ self error: 'permutation failed' ].
	count := aString last asString asNumber.
	arg := aString copyFrom: 1 to: aString size - 1.
	aCollection
		withIndexDo: [ :each :index | 
			each = arg
				ifTrue: [ count = 1
						ifTrue: [ ^ index ]
						ifFalse: [ count := count - 1 ] ] ].
	self error: 'permutation failed'
]

{ #category : #accessing }
BlockDef >> id [
	^ id ifNil: [ id := self block hash ]
]

{ #category : #accessing }
BlockDef >> id: anInteger [
	id := anInteger
]

{ #category : #accessing }
BlockDef >> imports [
	^ imports ifNil: [ #() ]
]

{ #category : #accessing }
BlockDef >> imports: anObject [
	imports := anObject
]

{ #category : #testing }
BlockDef >> isBlockDef [
	^ true
]

{ #category : #testing }
BlockDef >> isReporter [
	^ self return ~= '-'
]

{ #category : #private }
BlockDef >> prefix [
	^ 'int'
]

{ #category : #printing }
BlockDef >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self id asString;
		nextPut: $,;
		nextPutAll: self block asString;
		nextPut: $)
]

{ #category : #private }
BlockDef >> privSelector: anObject [
	"do not set selector explicitly"
	selector := anObject
]

{ #category : #accessing }
BlockDef >> return [
	^ return ifNil: [ '-' ]
]

{ #category : #accessing }
BlockDef >> return: anObject [
	return := anObject
]

{ #category : #accessing }
BlockDef >> selector [
	| st num |
	selector ifNotNil: [ ^ selector ].
	st := WriteStream on: String new.
	st
		nextPutAll: self prefix;
		nextPutAll: self id asString.
	num := self block count: [ :each | each = $% ].
	1 to: num do: [ :each | 
		st
			nextPutAll: 'arg';
			nextPutAll: each asString;
			nextPut: $: ].
	selector := st contents asSymbol.
	^ selector
]

{ #category : #private }
BlockDef >> valueOf: anObject [
	"to be integrated with Generator"
	anObject isBlock ifTrue: [ ^ anObject value asString ].
	^ anObject asString
]
