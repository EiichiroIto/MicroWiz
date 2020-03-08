Class {
	#name : #ULispGenerator,
	#superclass : #MicroWizGenerator,
	#category : #'MicroWiz-uLisp'
}

{ #category : #private }
ULispGenerator >> binaryFunction: aSymbol arg1: anObject1 arg2: anObject2 [
	| a b |
	a := self valueOf: anObject1.
	b := self valueOf: anObject2.
	^ '(' , aSymbol , ' ' , a , ' ' , b , ')'
]

{ #category : #'control ops' }
ULispGenerator >> doForeverBegin [
	self appendWithNewline: '(loop'
]

{ #category : #'control ops' }
ULispGenerator >> doForeverEnd [
	self appendWithNewline: ')'
]

{ #category : #'control ops' }
ULispGenerator >> doIfBegin: cond [
	self appendWithNewline: '(if ' , (self valueOf: cond) , ' (progn '
]

{ #category : #'control ops' }
ULispGenerator >> doIfElse [
	self appendWithNewline: ') (progn'
]

{ #category : #'control ops' }
ULispGenerator >> doIfEnd [
	self appendWithNewline: '))'
]

{ #category : #'control ops' }
ULispGenerator >> doRepeatBegin: aNumber var: aString [
	"(dotimes (var number [result]) form*)"

	self
		appendWithNewline: '(dotimes (' , aString , ' ' , aNumber asString , ')'
]

{ #category : #'control ops' }
ULispGenerator >> doRepeatEnd [
	self appendWithNewline: ')'
]

{ #category : #'control ops' }
ULispGenerator >> doWhenBegin: val [
	self appendWithNewline: '(when ' , (self valueOf: val)
]

{ #category : #'control ops' }
ULispGenerator >> doWhenEnd [
	self appendWithNewline: ')'
]

{ #category : #'code generator' }
ULispGenerator >> generateIndent: anInteger [
	anInteger timesRepeat: [ stream nextPutAll: ' ' ]
]

{ #category : #'code generator' }
ULispGenerator >> generateIntCode: aSymbol arguments: aCollection for: aScript [
	| blockDef code |
	blockDef := aScript intBlockDefOf: aSymbol.
	code := blockDef codeWithArgs: aCollection.
	blockDef isReporter
		ifTrue: [ ^ code ].
	code linesDo: [ :each | self appendWithNewline: each ]
]

{ #category : #'code generator' }
ULispGenerator >> generatePass [
	"do nothing"
]

{ #category : #'code generator' }
ULispGenerator >> literalStringFrom: anObject [ 
	((anObject isString)
		and: [anObject isNumberString not])
		ifTrue: [^ self quotedString: anObject].
	^ anObject asString
]

{ #category : #private }
ULispGenerator >> localVarArgString: aString [ 
	^ aString
]

{ #category : #private }
ULispGenerator >> quotedString: aString [ 
	^ (#('nil' 't') includes: aString)
		ifTrue: [ aString ]
		ifFalse: [ '"' , aString , '"' ]
]

{ #category : #'control ops' }
ULispGenerator >> stopThread [
	"do nothing"
]

{ #category : #private }
ULispGenerator >> unaryFunction: aSymbol arg: anObject1 [
	^ '(' , aSymbol , ' ' , (self valueOf: anObject1) , ')'
]

{ #category : #'control ops' }
ULispGenerator >> withI2cBegin: addr var: var [
	self
		appendWithNewline: '(with-i2c (' , var , ' ' , (self valueOf: addr) , ')'
]

{ #category : #'control ops' }
ULispGenerator >> withI2cEnd [
	self appendWithNewline: ')'
]
