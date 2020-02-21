Class {
	#name : #ExtBlockDef,
	#superclass : #Object,
	#instVars : [
		'block',
		'defaultArgs',
		'code',
		'selector',
		'imports',
		'return',
		'moduleName'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
ExtBlockDef >> argPermutation [
	^ CommandBlockMorph
		argPermutationForSpec: self block
		withTranslation: self code
]

{ #category : #api }
ExtBlockDef >> assignSelector: aString id: anInteger [
	| st num |
	self moduleName: aString.
	st := WriteStream on: String new.
	st
		nextPutAll: 'ext';
		nextPutAll: aString asCamelCase;
		nextPutAll: anInteger asString.
	num := self block count: [ :each | each = $% ].
	1 to: num do: [ :each | 
		st
			nextPutAll: 'arg';
			nextPutAll: each asString;
			nextPut: $: ].
	self selector: st contents asSymbol
]

{ #category : #accessing }
ExtBlockDef >> block [
	^ block
]

{ #category : #accessing }
ExtBlockDef >> block: anObject [
	block := anObject
]

{ #category : #api }
ExtBlockDef >> blockTuple [
	^ {self block.
	self return.
	self selector} , self defaultArgs
]

{ #category : #accessing }
ExtBlockDef >> code [
	^ code
]

{ #category : #accessing }
ExtBlockDef >> code: anObject [
	code := anObject
]

{ #category : #api }
ExtBlockDef >> codeWithArgs: aCollection [
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
ExtBlockDef >> defaultArgs [
	^ defaultArgs ifNil: [ #() ]
]

{ #category : #accessing }
ExtBlockDef >> defaultArgs: anObject [
	defaultArgs := anObject
]

{ #category : #private }
ExtBlockDef >> evaluatedArgs: aCollection [
	| args |
	args := aCollection collect: [ :each | self valueOf: each ].
	^ self argPermutation collect: [ :each | args at: each ]
]

{ #category : #accessing }
ExtBlockDef >> imports [
	^ imports ifNil: [ #() ]
]

{ #category : #accessing }
ExtBlockDef >> imports: anObject [
	imports := anObject
]

{ #category : #testing }
ExtBlockDef >> isReporter [
	^ self return ~= '-'
]

{ #category : #accessing }
ExtBlockDef >> moduleName [
	^ moduleName
]

{ #category : #accessing }
ExtBlockDef >> moduleName: aString [
	moduleName := aString
]

{ #category : #accessing }
ExtBlockDef >> return [
	^ return ifNil: [ '-' ]
]

{ #category : #accessing }
ExtBlockDef >> return: anObject [
	return := anObject
]

{ #category : #accessing }
ExtBlockDef >> selector [
	^ selector
]

{ #category : #accessing }
ExtBlockDef >> selector: anObject [
	selector := anObject
]

{ #category : #private }
ExtBlockDef >> valueOf: anObject [
	"to be integrated with Generator"
	anObject isBlock ifTrue: [ ^ anObject value asString ].
	^ anObject asString
]
