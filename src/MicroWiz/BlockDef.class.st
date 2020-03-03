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
	parsedSpec := self parseCommandSpec: block.
	parsedSpecArgs := parsedSpec
		select: [ :s | self isArgSpec: s ].
	parsedTranslatedSpec := self parseCommandSpec: code.
	parsedTranslatedSpecArgs := parsedTranslatedSpec
		select: [ :s | self isArgSpec: s ].
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
					(r atEnd not and: [ r peek ]) = $'
						ifTrue: [ r next ].
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
	| args argPermutation result |
	args := aCollection collect: [ :each | self valueOf: each ].
	argPermutation := self argPermutation.
	result := argPermutation collect: [ :each | args at: each ].
	((self parseCommandSpec: code) select: [ :s | self isArgSpec: s ])
		withIndexDo: [ :each :index | 
			(self isUnquoteArg: each)
				ifTrue: [ result at: index put: (self unquoteString: (result at: index)) ] ].
	^ result
]

{ #category : #private }
BlockDef >> findPos: aString in: aCollection [
	| pos arg count |
	arg := aString copyWithout: $'.
	pos := aCollection indexOf: arg.
	pos > 0
		ifTrue: [ ^ pos ].
	arg last isDigit
		ifFalse: [ self error: 'permutation failed' ].
	count := arg last asString asNumber.
	arg := arg copyFrom: 1 to: arg size - 1.
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
BlockDef >> isArgSpec: aString [
	"Answer true if the given string is an argument specification."

	^ aString size > 1 and: [ aString first = $% ]
]

{ #category : #testing }
BlockDef >> isBlockDef [
	^ true
]

{ #category : #testing }
BlockDef >> isReporter [
	^ self return ~= '-'
]

{ #category : #testing }
BlockDef >> isUnquoteArg: aString [
	"Answer true if the given string is an argument specification."

	^ aString size > 2
		and: [ aString first = $% and: [ aString second = $' ] ]
]

{ #category : #private }
BlockDef >> parseCommandSpec: aString [
	| tokens str i in out pair |
	tokens := ([ :c | c isSeparator ] split: aString)
		select: [ :e | e notEmpty ].
	in := ReadStream on: tokens.
	out := WriteStream on: Array new.
	[ in atEnd ]
		whileFalse: [ str := in next.
			[ i := str indexOf: $%.
			i = 0 ]
				whileFalse: [ i > 1
						ifTrue: [ out nextPut: (str copyFrom: 1 to: i - 1) ].
					pair := self splitArg: (str copyFrom: i to: str size).
					out nextPut: pair first.
					str := pair second ].
			str ifNotEmpty: [ out nextPut: str ] ].
	^ out contents
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
BlockDef >> splitArg: aString [
	| in c arg rest |
	in := ReadStream on: aString.
	arg := WriteStream on: String new.
	c := in next.
	c = $%
		ifFalse: [ self error: 'invalid arg' ].
	arg nextPut: c.
	in peek = $'
		ifTrue: [ arg nextPut: in next ].
	(in atEnd not and: [ in peek isLetter ])
		ifTrue: [ arg nextPut: in next ].
	[ in atEnd not
		and: [ c := in peek.
			c isDigit ] ] whileTrue: [ arg nextPut: in next ].
	rest := in upToEnd.
	^ {arg contents.
	rest}
]

{ #category : #private }
BlockDef >> unquoteString: aString [
	(aString first = $' and: [ aString last = $' ])
		ifFalse: [ ^ aString ].
	^ aString copyFrom: 2 to: aString size - 1
]

{ #category : #private }
BlockDef >> valueOf: anObject [
	"to be integrated with Generator"
	anObject isBlock ifTrue: [ ^ anObject value asString ].
	^ anObject asString
]
